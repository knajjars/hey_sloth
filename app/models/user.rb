class User < ApplicationRecord
  has_many :testimonials
  has_one :collect_link

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
