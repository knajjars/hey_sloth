class User < ApplicationRecord
  has_many :testimonials
  has_one :collect_link
  has_many :authorizations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable,
         omniauth_providers: %i[twitter]

  def has_connection_with(provider)
    auth = authorizations.where(provider: provider).first
    if auth.present?
      auth.token.present?
    else
      false
    end
  end
end
