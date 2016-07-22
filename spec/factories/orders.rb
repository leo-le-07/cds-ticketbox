FactoryGirl.define do
  factory :order do
    order_number "MyString"
    event nil
    name "MyString"
    address "MyString"
    email "MyString"
    phone "MyString"
    total_price "9.99"
  end
end
