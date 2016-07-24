FactoryGirl.define do
  sequence :name do |n|
    Faker::Name.name + n.to_s
  end

  factory :event do |e|
    venue
    association :category, factory: :entertainment, strategy: :build

    association :owner, factory: :owner, strategy: :build

    e.name
    e.unaccent_name { |a| Event.unaccent(a.name) }
    e.extended_html_description "<p>Description in html format</p>"
    e.starts_at DateTime.strptime('23/10/2016 13:50', '%d/%m/%Y %H:%M')
    e.ends_at DateTime.strptime('23/10/2016 15:50', '%d/%m/%Y %H:%M')
  end
end
