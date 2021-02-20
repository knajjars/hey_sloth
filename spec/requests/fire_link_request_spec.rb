require 'rails_helper'

RSpec.describe "FireLink", type: :request do
  let(:fire_link) { FactoryBot.create(:fire_link) }
  let(:user) { fire_link.user }
  let(:other_user) { FactoryBot.create(:user) }
  let(:valid_body) { (FactoryBot.attributes_for(:fire_link)) }
  let(:invalid_body) { (FactoryBot.attributes_for(:fire_link)).except(:tag) }
  let(:valid_update_body) { (FactoryBot.attributes_for(:fire_link)) }
  let(:invalid_update_body) { (FactoryBot.attributes_for(:fire_link)).merge({ random_attr: "random" }) }

  describe '#index' do
    it 'redirects to login if not authenticated' do
      get fire_link_index_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders fire links for authenticated user' do
      sign_in user
      get fire_link_index_url
      expect(response).to have_http_status(200)
      expect(response).to render_template('fire_link/index')
      expect(response.body).to include(fire_link.tag)
    end
  end

  describe '#new' do
    it 'redirects to login if not authenticated' do
      get fire_link_index_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders fire_link new form for authenticated user' do
      sign_in user
      get new_fire_link_url
      expect(response).to have_http_status(200)
      expect(response).to render_template("fire_link/new")
    end
  end

  describe '#create' do
    it 'redirects to login if not authenticated' do
      post fire_link_index_url, params: { fire_link: valid_body }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'creates fire link for authenticated user' do
      sign_in user
      expect {
        post fire_link_index_url, params: { fire_link: valid_body }
      }.to change(FireLink, :count).by(1)

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template("fire_link/index")
      expect(FireLink.find_by_tag(valid_body[:tag]).user.id).to eq(user.id)
    end

    it 'renders errors for missing attributes of fire link' do
      sign_in user
      expect {
        post fire_link_index_url, params: { fire_link: invalid_body }
      }.to_not change(FireLink, :count)

      expect(response).to render_template("fire_link/new")
      expect(response.body).to include("Tag can&#39;t be blank")
    end
  end

  describe '#edit' do
    it 'redirects to login if not authenticated' do
      get edit_fire_link_url(fire_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders fire_link new form for authenticated user' do
      sign_in user
      get edit_fire_link_url(fire_link.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template("fire_link/edit")
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      get edit_fire_link_url(fire_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("Not authorized")
    end
  end

  describe '#update' do
    it 'redirects to login if not authenticated' do
      patch fire_link_url(fire_link.id), params: { fire_link: valid_body }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'updates fire link for authenticated user' do
      sign_in user
      expect(FireLink.find(fire_link.id).tag).to eq(fire_link.tag)
      expect {
        patch fire_link_url(fire_link.id), params: { fire_link: valid_update_body }
      }.to_not change(FireLink, :count)

      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template("fire_link/index")
      expect(FireLink.find(fire_link.id).tag).to eq(valid_update_body[:tag])
    end

    it 'does not update fire link with invalid attributes for authenticated user' do
      sign_in user
      expect(FireLink.find(fire_link.id).tag).to eq(fire_link.tag)
      expect {
        patch fire_link_url(fire_link.id), params: { fire_link: invalid_update_body }
      }.to_not change(FireLink, :count)
      expect(response).to have_http_status(302)
      follow_redirect!
      expect(response).to render_template("fire_link/index")
      expect(FireLink.find(fire_link.id)).to eq(fire_link)
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      patch fire_link_url(fire_link.id), params: { fire_link: valid_update_body }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("Not authorized")
    end
  end

  describe '#destroy' do
    it 'redirects to login if not authenticated' do
      delete fire_link_url(fire_link.id)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'deletes fire link for authenticated user' do
      sign_in user
      id = fire_link.id
      expect {
        delete fire_link_url(id)
      }.to change(FireLink, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/fire_link')
      follow_redirect!
      expect(response).to render_template("fire_link/index")
    end

    it 'redirects to not authorized for other authenticated user' do
      sign_in other_user
      id = fire_link.id
      expect {
        delete fire_link_url(id)
      }.to_not change(FireLink, :count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include("Not authorized")
    end
  end
end
