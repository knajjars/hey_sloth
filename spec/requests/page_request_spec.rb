require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe '#index' do
    before do
      get root_url
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
