class User < ActiveRecord::Base
  before_create :downcase_fields

  has_many :events, foreign_key: 'owner_id'

  has_secure_password

  private
    def downcase_fields
      self[:email].downcase!
    end
end
