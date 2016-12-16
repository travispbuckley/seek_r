class User < ApplicationRecord
  has_many :revisions, foreign_key: :editor_id
  has_many :articles

  validates :username, :password_digest, presence: true
  validates :role, presence: true

  has_secure_password
end
