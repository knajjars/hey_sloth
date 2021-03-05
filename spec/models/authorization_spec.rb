require 'rails_helper'

RSpec.describe Authorization, type: :model do
  let(:authorization) do
    create(:authorization, :with_user, token: 'token', secret: 'secret', provider: 'twitter',
                                       link: 'https://www.twitter.com/heysloth')
  end

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

  it 'has link' do
    expect(authorization.link).to eq('https://www.twitter.com/heysloth')
  end

  it 'belongs to user' do
    user_association = Authorization.reflect_on_association :user
    expect(user_association.macro).to eq :belongs_to
  end

  describe '#twitter_handle' do
    it 'returns the Twitter handle prefixed with @' do
      expect(authorization.twitter_handle).to eq('@heysloth')
    end
  end
end
