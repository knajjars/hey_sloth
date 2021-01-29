require 'rails_helper'

RSpec.describe 'Testimonials', type: :request do
  let(:testimonial) { FactoryBot.create(:testimonial, :with_shareable_link) }
  let(:user) { testimonial.user }
  let(:other_user) { FactoryBot.create(:user) }

  describe '#index' do
    it 'redirects to login if not authenticated' do
      get testimonials_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders testimonials for authenticated user' do
      sign_in user
      get testimonials_url
      expect(response).to have_http_status(200)
      expect(response).to render_template('testimonials/index')
    end
  end

  describe '#show' do
    it 'redirects to login if not authenticated' do
      get testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders testimonials for authenticated user of testimonial' do
      sign_in user
      get testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(200)
      expect(response).to render_template('testimonials/show')
      expect(response.body).to include(testimonial.name)
      expect(response.body).to include(testimonial.testimonial)
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      get testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end
  end

  describe '#destroy' do
    it 'redirects to login if not authenticated' do
      delete testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'deletes testimonial for authorized user' do
      sign_in user
      expect {
        delete testimonial_url(testimonial.hashid)
      }.to change(Testimonial, :count).by(-1)
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response.body).to include('Testimonial was successfully destroyed')
    end

    it 'redirects to not authorized for other user of testimonial' do
      sign_in other_user
      delete testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end
  end

  describe '#toggle_showcase' do
    it 'redirects to login if not authenticated' do
      post toggle_showcase_testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'toggles showcase of testimonial for authorized user' do
      hashid = testimonial.hashid
      initial_showcase = Testimonial.find_by_hashid(hashid).showcase
      sign_in user
      post toggle_showcase_testimonial_url(hashid)
      expect(response).to have_http_status(302)
      expect(Testimonial.find_by_hashid(hashid).showcase).to be(!initial_showcase)
    end

    it 'redirects to not authorized for other user of testimonial' do
      sign_in other_user
      post toggle_showcase_testimonial_url(testimonial.hashid)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include('Not authorized')
    end
  end
end
