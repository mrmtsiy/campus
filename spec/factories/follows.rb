FactoryBot.define do
  factory :follow do
    user_id   { FactoryBot.create(:user).id }
    target_user_id    { FactoryBot.create(:user).id }
  end
end