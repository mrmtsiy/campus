FactoryBot.define do
  factory :comment do
    comment {'コメントです'}
    user
    post
  end
end