FactoryGirl.define do
  factory :venue do
    association :region, factory: :hochiminh, strategy: :build

    name {Faker::Address.city}
    full_address "231 Hoang Hoa Tham - Binh Thanh"
  end
end
