require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:other_user) { build(:user) }

  it 'has email field' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'has valid email field' do
    user.email = 'not_an_email'
    expect(user).to_not be_valid

    user.email = 'test@test.com'
    expect(user).to be_valid
  end

  it 'has unique email field' do
    email = 'test@test.com'
    user.email = email
    user.save!
    other_user.email = email
    expect { other_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has public_token' do
    user.public_token = nil
    expect { user.save! }.to_not raise_error
    user.reload
    expect(user.public_token).to_not be_nil
  end

  it 'does not update public_token when updating user' do
    user.save!
    user.reload
    original_public_token = user.public_token
    user.email = 'other@email.com'
    user.save!
    user.reload
    expect(user.public_token).to eq(original_public_token)
  end

  it 'has unique public_token' do
    public_token = 'public_token'
    user.public_token = public_token
    user.save!
    other_user.public_token = public_token
    expect { other_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can have a company name field' do
    expect(user).to be_valid
  end

  it 'can have many testimonials' do
    testimonials = User.reflect_on_association :testimonials
    expect(testimonials.macro).to eq :has_many
  end

  it 'can have one fire_link' do
    fire_link = User.reflect_on_association :fire_link
    expect(fire_link.macro).to eq :has_one
  end

  it 'can have many authorizations' do
    authorizations = User.reflect_on_association :authorizations
    expect(authorizations.macro).to eq :has_many
  end

end
