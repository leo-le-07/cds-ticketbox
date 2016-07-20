class User < ActiveRecord::Base
  before_create :downcase_fields

  has_secure_password

  private
    def downcase_fields
      self[:email].downcase!
    end
end
