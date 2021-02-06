require 'rails_helper'

RSpec.describe Testimonial, type: :model do
  let(:testimonial) { FactoryBot.create(:testimonial, :with_shareable_link) }
  let(:shareable_link) { FactoryBot.create(:shareable_link, :image_not_required) }
  let(:testimonial_with_rich_text_params) { FactoryBot.attributes_for(:testimonial, :with_rich_text) }
  let(:testimonial_params) { FactoryBot.attributes_for(:testimonial) }
  let(:testimonial_tweet) { FactoryBot.create(:testimonial, :tweet) }
  let(:testimonial_image_required) { FactoryBot.build(:testimonial, :with_shareable_link_and_image_required) }

  it 'requires a name' do
    testimonial.name = nil
    expect(testimonial).to_not be_valid

    testimonial.name = Faker::Internet.username
    expect(testimonial).to be_valid
  end

  it 'requires content' do
    testimonial.content = nil
    expect(testimonial).to_not be_valid

    testimonial.content = Faker::Lorem.paragraph
    expect(testimonial).to be_valid
  end

  describe '#rich_text_or_content' do
    it 'has rich_text_or_content virtual field' do
      expect(testimonial.rich_text_or_content).to eq(testimonial.content)
    end

    it 'can create testimonial without content but with rich_text' do
      testimonial_with_rich_text = shareable_link.testimonials.new testimonial_with_rich_text_params.merge({ user: shareable_link.user })
      expect(testimonial_with_rich_text).to be_valid

      testimonial_without_rich_text = shareable_link.testimonials.new testimonial_params.merge({ user: shareable_link.user })
      expect(testimonial_without_rich_text).to be_valid
    end

    it 'requires either content or rich_text' do
      testimonial_without_rich_text_and_content = shareable_link.testimonials.new testimonial_params.merge({ user: shareable_link.user }).except(:content)
      expect(testimonial_without_rich_text_and_content).to_not be_valid
    end

    it 'prioritizes rich text over plain text' do
      rich_text = '<div><strong>This is awesome!<br></strong><br></div><ul><li>I am a test</li><li><em>and this rocks!</em></li><li><del>truly.</del></li></ul>'
      plain_text = "This is awesome!\n• I am a test\n• and this rocks!\n• truly."

      expect(testimonial.rich_text_or_content).to eq(testimonial.content)
      testimonial.rich_text = rich_text
      testimonial.save!
      expect(testimonial.rich_text).to be_an_instance_of(ActionText::RichText)
      expect(testimonial.content).to eq(plain_text)
      expect(testimonial.rich_text_or_content).to eq(testimonial.rich_text)
    end

    it 'displays content when there is no rich_text' do
      expect(testimonial.rich_text).to be_nil
      expect(testimonial.rich_text_or_content).to eq(testimonial.content)
    end
  end

  it 'can have a company' do
    testimonial.company = nil
    expect(testimonial).to be_valid

    testimonial.name = Faker::Company.name
    expect(testimonial).to be_valid
  end

  it 'can have a role' do
    testimonial.role = nil
    expect(testimonial).to be_valid

    testimonial.role = Faker::Job.field
    expect(testimonial).to be_valid
  end

  it 'can have a social_link' do
    testimonial.social_link = nil
    expect(testimonial).to be_valid

    testimonial.social_link = Faker::Internet.url
    expect(testimonial).to be_valid
  end

  it 'can have a tweet_status_id' do
    testimonial.tweet_status_id = nil
    expect(testimonial).to be_valid

    testimonial.tweet_status_id = Faker::Twitter.status
    expect(testimonial).to be_valid
  end

  it 'can have a tweet_url' do
    testimonial.tweet_url = nil
    expect(testimonial).to be_valid

    testimonial.tweet_url = Faker::Internet.url
    expect(testimonial).to be_valid
  end

  it 'does not showcase by default' do
    expect(testimonial.showcase).to be(false)
  end

  describe 'image' do
    it 'requires image if not tweet and shareable link requires it' do
      expect(testimonial_image_required).to_not be_valid

      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'image.png'), 'rb'),
        filename: 'image.png',
        content_type: 'image/png'
      ).signed_id

      testimonial_image_required.image.attach(image)
      expect(testimonial_image_required).to be_valid
    end

    it 'does not require image if tweet' do
      expect(testimonial_image_required).to_not be_valid
      testimonial_image_required.tweet!
      expect(testimonial_image_required).to be_valid
    end

    it 'does not require if shareable_link does not requires it' do
      expect(testimonial).to be_valid
    end
  end

  describe '#tweets' do
    it 'filters all Tweet testimonials' do
      FactoryBot.create_list(:testimonial, 10, :tweet)
      expect(Testimonial.tweets.count).to eq(10)
    end
  end

  describe '#showcased' do
    it 'filters all showcased testimonials' do
      FactoryBot.create_list(:testimonial, 10, :tweet, showcase: true)
      FactoryBot.create_list(:testimonial, 5, :tweet, showcase: false)
      expect(Testimonial.showcased.count).to eq(10)
    end
  end

  describe 'source' do
    it 'can be tweet' do
      expect(testimonial_tweet.source).to eq('tweet')
    end

    it 'can be link' do
      expect(testimonial.source).to eq('link')
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user_association = Testimonial.reflect_on_association :user
      expect(user_association.macro).to eq :belongs_to
    end

    it 'can belong to a shareable_link' do
      shareable_link_association = Testimonial.reflect_on_association :shareable_link
      expect(shareable_link_association.macro).to eq :belongs_to
      expect(shareable_link_association.options[:optional]).to eq true
    end
  end

  describe '.hashid' do
    it 'has a hashid' do
      expect(testimonial.hashid).to be_an_instance_of String
    end

    it 'can be searched by hashid' do
      expect(Testimonial.find_by_hashid(testimonial.hashid)).to eq(testimonial)
    end
  end
end
