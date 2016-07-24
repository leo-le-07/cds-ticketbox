FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name "Leo Le"
    email {Faker::Internet.free_email}
    password "123"
  end
end
