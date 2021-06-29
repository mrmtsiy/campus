FactoryBot.define do
  factory :post do
    title       {"camp"}
    content     {"enjoy"}
    tag_list    {"tag"}
    association :user
    after(:build) do |item|
      item.post_image.attach(io: File.open('spec/fixtures/free_user.png'), filename: 'free_user.png', content_type: 'image/jpg')
    end
  end
end