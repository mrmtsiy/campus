FactoryBot.define do
  factory :user do
    username            {"test"}
    sequence(:email)    {|n| "test#{n}@test.com"}
    profile             {'testprofile'}
    password            {'testpass'}
  end
end