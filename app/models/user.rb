class User < ApplicationRecord
  has_many :testimonials
  has_many :collect_links

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
