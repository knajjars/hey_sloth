require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:user) { create(:user) }
  let(:authorization) { create(:authorization, user: user) }

  it 'decrypts user token' do
    expect(authorization.token).to eq('token')
  end

  it 'decrypts user secret token' do
    expect(authorization.secret).to eq('secret')
  end

  it 'belongs to user' do
    user_association = Authorization.reflect_on_association :user
    expect(user_association.macro).to eq :belongs_to
  end
end
