require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:user) {
    User.new(email: "test@test.com", company_name: "Binary Sunset Inc.", password: 'password', password_confirmation: 'password').tap do |u|
      u.skip_confirmation!
      u.save!
    end
  }

  it 'decrypts user token' do
    authorization = Authorization.new token: 'token', secret: 'secret', user: user
    authorization.save!

    expect(authorization.token).to eq('token')

  end

  it 'decrypts user secret token' do
    authorization = Authorization.new token: 'token', secret: 'secret', user: user
    authorization.save!

    expect(authorization.secret).to eq('secret')
  end

  it 'belongs to user' do
    user_association = Authorization.reflect_on_association :user
    expect(user_association.macro).to eq :belongs_to
  end
end
