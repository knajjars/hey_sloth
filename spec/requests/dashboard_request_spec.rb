require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  describe '#index' do
    it 'redirects to login if not authenticated' do
      get app_root_url
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/login")
    end

    it 'renders dashboard index for authenticated user' do
      user = FactoryBot.create(:user)
      sign_in user
      get app_root_url
      expect(response).to have_http_status(200)
      expect(response).to render_template("dashboard/index")
    end

    describe '#collect' do
      it 'redirects to login if not authenticated' do
        get collect_url
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/login")
      end

      it 'renders collect view for authenticated user' do
        user = FactoryBot.create(:user)
        sign_in user
        get collect_url
        expect(response).to have_http_status(200)
        expect(response).to render_template("dashboard/collect")
      end
    end
  end

end
