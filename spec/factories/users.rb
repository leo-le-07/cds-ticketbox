FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name "Leo Le"
    email "leole@gmail.com"
    password "123"
  end
end
