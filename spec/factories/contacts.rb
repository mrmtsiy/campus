FactoryBot.define do
  factory :contact do
    name {'morimoto'}
    message {'お問い合わせテスト'}
    user
    user_id { FactoryBot.create(:user).id }
  end
end