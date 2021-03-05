require 'rails_helper'

RSpec.describe FireLink, type: :model do
  let(:fire_link) { create(:fire_link, url: 'Some Url') }
  let(:fire_links) { create_list(:fire_link, 3, url: 'Some Url') }
  let(:fire_link_with_testimonial) { FactoryBot.create(:fire_link, :image_not_required) }
  let(:testimonial) { FactoryBot.create(:testimonial, fire_link: fire_link_with_testimonial) }

  describe 'url' do
    it 'exists' do
      expect(fire_link).to be_valid
    end

    it 'generates slug based on url' do
      expect(fire_link.url).to eq('Some Url')
      expect(fire_link.slug).to eq('some-url')
    end

    it 'updates slug based on url' do
      expect(fire_link.slug).to eq('some-url')

      fire_link.url = 'Other url'
      fire_link.save

      expect(fire_link.slug).to eq('other-url')
    end

    it 'auto increment slug if url already exists' do
      slugs = fire_links.map(&:slug)
      expect(slugs).to contain_exactly(
        'some-url',
        'some-url-2',
        'some-url-3'
      )
    end

    it 'is between 4 and 30 characters' do
      fire_link.url = '123'
      expect(fire_link).to_not be_valid

      fire_link.url = '100000000020000000003000000000' + '4'
      expect(fire_link).to_not be_valid
    end

    it 'does not allow reserved words' do
      %w[new edit index session login logout users admin
         stylesheets assets javascripts javascript images].each do |word|
        fire_link.url = word
        expect(fire_link).to_not be_valid

        fire_link.url = word.upcase
        expect(fire_link).to_not be_valid
      end
    end
  end

  describe '_required fields' do
    it 'has image_required' do
      expect(fire_link.image_required).to be(true).or be(false)
    end

    it 'has job_required' do
      expect(fire_link.job_required).to be(true).or be(false)
    end
  end

  describe 'attached' do
    it 'can have a logo' do
      logo = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'image.png'), 'rb'),
        filename: 'image.png',
        content_type: 'image/png'
      ).signed_id

      fire_link.logo.attach(logo)

      expect(fire_link).to be_valid
    end

    it 'is an image' do
      logo = ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('spec', 'fixtures', 'file.js'), 'rb'),
        filename: 'file.js',
        content_type: 'text/javascript'
      ).signed_id

      fire_link.logo.attach(logo)

      expect(fire_link).to be_invalid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      user = FireLink.reflect_on_association :user
      expect(user.macro).to eq :belongs_to
    end

    it 'can have many testimonials' do
      testimonials = FireLink.reflect_on_association :testimonials
      expect(testimonials.macro).to eq :has_many
    end

    it 'removes association from testimonials when deleted' do
      expect(testimonial.fire_link).to_not be_nil
      expect(fire_link_with_testimonial.testimonials.count).to eq(1)

      expect do
        fire_link_with_testimonial.destroy!
      end.to change(FireLink, :count).by(-1)

      testimonial.reload
      expect(testimonial.fire_link).to be_nil
    end
  end
end
