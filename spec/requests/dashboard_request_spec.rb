require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe '#index' do
    it 'redirects to login if not authenticated' do
      get app_root_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to('/login')
    end

    it 'renders dashboard index for authenticated user' do
      sign_in user
      get app_root_url
      expect(response).to have_http_status(200)
      expect(response).to render_template('dashboard/index')
    end
  end
end
