FactoryGirl.define do
  factory :event do
    venue
    association :category, factory: :entertainment, strategy: :build
    owner

    name "Festival spring music"
    extended_html_description "<p>Description in html format</p>"
    starts_at DateTime.strptime('23/10/2016 13:50', '%d/%m/%Y %H:%M')
    ends_at DateTime.strptime('23/10/2016 15:50', '%d/%m/%Y %H:%M')
  end
end
