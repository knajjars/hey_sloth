require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:authorization) { create(:authorization, :with_user, token: 'token', secret: 'secret', provider: 'twitter') }

  it 'decrypts user token' do
    expect(authorization.token).to eq('token')
  end

  it 'decrypts user secret token' do
    expect(authorization.secret).to eq('secret')
  end

  it 'has "twitter"' do
    authorization.provider = 'Twitter'
    expect(authorization).to_not be_valid

    authorization.provider = nil
    expect(authorization).to_not be_valid

    authorization.provider = 'twitter'
    expect(authorization).to be_valid
  end

  it 'has provider' do
    expect(authorization.secret).to eq('secret')
  end

  it 'belongs to user' do
    user_association = Authorization.reflect_on_association :user
    expect(user_association.macro).to eq :belongs_to
  end
end
