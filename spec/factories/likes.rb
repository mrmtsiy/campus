FactoryBot.define do
  factory :like do
    user
    post
    post_id   { FactoryBot.create(:post).id }
  end
end