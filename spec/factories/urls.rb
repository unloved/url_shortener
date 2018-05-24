FactoryBot.define do
  factory :url do
    sequence(:original_url) { |n| "http://randomlink#{n}.com" }
    sequence(:strategy) { |n| Url::STRATEGIES.sample }
  end
end