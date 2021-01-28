require 'rails_helper'

RSpec.describe "ShareableLinks", type: :request do
  let(:shareable_link) { FactoryBot.create(:shareable_link) }
  let(:user) { shareable_link.user }
  let(:other_user) { FactoryBot.create(:user) }
  let(:valid_body) { (FactoryBot.attributes_for(:shareable_link)) }
  let(:invalid_body) { (FactoryBot.attributes_for(:shareable_link)).except(:tag) }

  describe '#index' do
    it 'redirects to login if not authenticated' do
      get shareable_links_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders shareable links for authenticated user' do
      sign_in user
      get shareable_links_url
      expect(response).to have_http_status(200)
      expect(response).to render_template('shareable_links/index')
      expect(response.body).to include(shareable_link.tag)
    end
  end

  describe '#show' do
    it 'redirects to login if not authenticated' do
      get shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders shareable_link for authenticated user' do
      sign_in user
      get shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template("shareable_links/show")
      expect(response.body).to include(shareable_link.tag)
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      get shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("Not authorized")
    end
  end

  describe '#new' do
    it 'redirects to login if not authenticated' do
      get new_shareable_link_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders shareable_link new form for authenticated user' do
      sign_in user
      get new_shareable_link_url
      expect(response).to have_http_status(200)
      expect(response).to render_template("shareable_links/new")
    end
  end

  describe '#create' do
    it 'redirects to login if not authenticated' do
      post shareable_links_url, params: { shareable_link: valid_body }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'creates shareable link for authenticated user' do
      sign_in user
      expect {
        post shareable_links_url, params: { shareable_link: valid_body }
      }.to change(ShareableLink, :count).by(1)

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template("shareable_links/show")
      expect(ShareableLink.find_by_tag(valid_body[:tag]).user.id).to eq(user.id)
    end

    it 'renders errors for missing attributes of shareable link' do
      sign_in user
      expect {
        post shareable_links_url, params: { shareable_link: invalid_body }
      }.to_not change(ShareableLink, :count)

      expect(response).to render_template("shareable_links/new")
      expect(response.body).to include("Tag can&#39;t be blank")
    end
  end

  describe '#edit' do
    it 'redirects to login if not authenticated' do
      get edit_shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders shareable_link new form for authenticated user' do
      sign_in user
      get edit_shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template("shareable_links/edit")
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      get edit_shareable_link_url(shareable_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("Not authorized")
    end
  end

  describe '#update' do
    it 'redirects to login if not authenticated' do
      patch shareable_link_url(shareable_link.id), params: { shareable_link: valid_body }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end


  end
end
