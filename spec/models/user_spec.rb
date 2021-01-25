require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new email: "test@test.com", password: 'password', password_confirmation: 'password' }
  it 'has email field' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'has valid email field' do
    subject.email = "not_an_email"
    expect(subject).to_not be_valid

    subject.email = "test@test.com"
    expect(subject).to be_valid
  end

  it 'can have a company name field' do
    subject.company_name = "Binary Sunset Inc."
    expect(subject).to be_valid
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
