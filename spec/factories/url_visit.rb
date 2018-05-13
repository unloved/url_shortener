FactoryBot.define do
  factory :url_visit do
    url
    sequence(:data) { |n| {key: n} }
  end
end