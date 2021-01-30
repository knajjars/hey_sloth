require 'rails_helper'

RSpec.describe 'Externals', type: :request do
  let(:testimonial_created) { FactoryBot.create(:testimonial, :with_shareable_link, showcase: true) }
  let(:testimonial_attributes) { FactoryBot.attributes_for(:testimonial, :tweet, showcase: true) }
  let(:user) { testimonial_created.user }
  let(:other_user) { FactoryBot.create(:user) }

  describe '#list_testimonials' do
    describe 'for non-existent public_token' do
      it 'returns 404 for non-existent public_token' do
        get get_testimonials_json_url(public_token: 'random')
        expect(response).to have_http_status(404)
        expect(response.body).to eq(JSON.dump({ message: 'Not found' }))
      end
    end

    describe 'for existent public_token' do
      it 'returns 200 and JSON format' do
        get get_testimonials_json_url(public_token: user.public_token)
        expect(response).to have_http_status(200)
        expect { JSON.parse(response.body) }.to_not raise_error
      end

      it 'returns only testimonials for user' do
        user.testimonials.create testimonial_attributes
        user.testimonials.create testimonial_attributes
        user.testimonials.create testimonial_attributes
        user.save!
        user.reload
        get get_testimonials_json_url(public_token: user.public_token)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).count).to eq(user.testimonials.showcased.count)

        other_user.testimonials.create testimonial_attributes
        other_user.save!
        other_user.reload
        expect(other_user.testimonials).to_not eq(user.testimonials)
        get get_testimonials_json_url(public_token: other_user.public_token)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).count).to eq(other_user.testimonials.showcased.count)
      end

      it 'returns only showcased testimonials' do
        user.testimonials.create testimonial_attributes.merge({ showcase: true })
        user.testimonials.create testimonial_attributes.merge({ showcase: false })
        user.save!
        user.reload
        get get_testimonials_json_url(public_token: user.public_token)
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).count).to eq(user.testimonials.showcased.count)
      end

      it 'returns only external fields' do
        get get_testimonials_json_url(public_token: user.public_token)
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body).first
        %w[name company role social_link testimonial source tweet_status_id tweet_url tweet_user_id created_at image_url].each do |key|
          expect(body).to have_key(key)
        end

        %w[user_id shareable_link_id showcase id updated_at tweet_image_url].each do |key|
          expect(body).to_not have_key(key)
        end
      end
    end
  end

  describe '#testimonials_widget' do
    xit ''
  end
end
