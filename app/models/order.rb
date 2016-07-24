class Order < ActiveRecord::Base
  # before_create :generate_order_number

  belongs_to :event
  has_many :order_details

  validates_presence_of :name, :email, :phone
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, message: "Email format is not correct" }
  # validates :order_number, uniqueness: {case_sensitive: false}

  accepts_nested_attributes_for :order_details

  def self.generate_order_number
    loop do
      @order_number = SecureRandom.hex(16/4).upcase
      break unless Order.exists?(order_number: @order_number)
    end
    @order_number
  end
end
