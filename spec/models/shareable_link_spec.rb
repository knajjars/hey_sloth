require 'rails_helper'

RSpec.describe ShareableLink, type: :model do
  let(:shareable_link) { create(:shareable_link, :with_user, tag: "Some Tag") }
  let(:shareable_links) { create_list(:shareable_link, 3, :with_user, tag: "Some Tag") }

  describe 'tag' do
    it 'exists' do
      expect(shareable_link).to be_valid
    end

    it 'generates slug based on tag' do
      expect(shareable_link.tag).to eq('Some Tag')
      expect(shareable_link.slug).to eq('some-tag')
    end

    it 'updates slug based on tag' do
      expect(shareable_link.slug).to eq('some-tag')

      shareable_link.tag = 'Other tag'
      shareable_link.save

      expect(shareable_link.slug).to eq('other-tag')

    end

    it 'auto increment slug if tag already exists' do
      slugs = shareable_links.map { |shareable_link| shareable_link.slug }
      expect(slugs).to contain_exactly(
                         "some-tag",
                         "some-tag-2",
                         "some-tag-3"
                       )
    end

    it 'is between 4 and 30 characters' do
      shareable_link.tag = '123'
      expect(shareable_link).to_not be_valid

      shareable_link.tag = '100000000020000000003000000000' + '4'
      expect(shareable_link).to_not be_valid
    end
  end

  describe '_required fields' do
    it 'has social_link_required' do
      expect(shareable_link.social_link_required).to be(true).or be(false)
    end

    it 'has image_required' do
      expect(shareable_link.image_required).to be(true).or be(false)
    end

    it 'has job_required' do
      expect(shareable_link.job_required).to be(true).or be(false)
    end
  end

  describe 'attached' do
    it 'can have a logo' do
      logo = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'logo.png'), 'rb'),
        filename: 'logo.png',
        content_type: 'image/png'
      ).signed_id

      shareable_link.logo.attach(logo)

      expect(shareable_link).to be_valid
    end

    it 'is an image' do
      logo = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'file.js'), 'rb'),
        filename: 'file.js',
        content_type: 'text/javascript'
      ).signed_id

      shareable_link.logo.attach(logo)

      expect(shareable_link).to be_invalid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user = ShareableLink.reflect_on_association :user
      expect(user.macro).to eq :belongs_to
    end

    it 'can have many testimonials' do
      testimonials = ShareableLink.reflect_on_association :testimonials
      expect(testimonials.macro).to eq :has_many
    end
  end

end
