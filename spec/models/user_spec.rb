require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  it 'has email field' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'has valid email field' do
    user.email = "not_an_email"
    expect(user).to_not be_valid

    user.email = "test@test.com"
    expect(user).to be_valid
  end

  it 'can have a company name field' do
    expect(user).to be_valid
  end

  it 'can have many testimonials' do
    testimonials = User.reflect_on_association :testimonials
    expect(testimonials.macro).to eq :has_many
  end

  it 'can have many shareable_links' do
    shareable_links = User.reflect_on_association :shareable_links
    expect(shareable_links.macro).to eq :has_many
  end

  it 'can have many authorizations' do
    authorizations = User.reflect_on_association :authorizations
    expect(authorizations.macro).to eq :has_many
  end

end
