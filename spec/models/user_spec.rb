require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has email field' do
    user = User.new password: 'password', password_confirmation: 'password'

    expect(user).to_not be_valid

  end

  it 'has valid email field' do
    user = User.new email: "not_an_email", password: 'password', password_confirmation: 'password'

    expect(user).to_not be_valid

    user.email = "test@test.com"
    expect(user).to be_valid
  end

  it 'can have a company name field' do
    user = User.new email: "test@test.com", company_name: "Binary Sunset Inc.", password: 'password', password_confirmation: 'password'
    expect(user).to be_valid
  end

  # it 'can have many testimonials' do
  #
  # end

  # if 'can have many shareable_links' do
  #  
  # end
  #
  # it 'can have many authorizations' do
  #  
  # end

end
