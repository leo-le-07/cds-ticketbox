FactoryGirl.define do
  factory :order_detail do
    order nil
    ticket_type nil
    quantity 1
    price "9.99"
    total_price "9.99"
  end
end
