FactoryGirl.define do
  factory :ticket_type do
    event

    name "Vip type 1"
    price 200000
    max_quantity 20
    min_in_order 0
    max_in_order 10
  end
end
