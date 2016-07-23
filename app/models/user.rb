class User < ActiveRecord::Base
  before_create :downcase_fields

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: "Email format is not correct" }

  has_many :events, foreign_key: 'owner_id'

  private
    def downcase_fields
      self[:email].downcase!
    end
end
