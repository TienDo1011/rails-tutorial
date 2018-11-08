FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "Lorem ipsum #{n}" }
    user
  end
end
