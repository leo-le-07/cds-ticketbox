FactoryGirl.define do
  factory :order_detail do
    order
    ticket_type
    # association :ticket_type, factory: :ticket_type, strategy: :build
    quantity 1
    price "9.99"
    total_price "9.99"
  end
end
