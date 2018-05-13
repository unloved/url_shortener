FactoryBot.define do
  factory :url do
    sequence(:original_url) { |n| "http://randomlink#{n}.com" }
  end
end