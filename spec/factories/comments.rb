FactoryBot.define do
  factory :comment do
    comment {'コメントです'}
    user    { post.user }
    post
  end
end