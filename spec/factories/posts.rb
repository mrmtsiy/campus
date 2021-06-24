FactoryBot.define do
  factory :post do
    title       {"camp"}
    content     {"enjoy"}
    user
    after(:build) do |item|
      item.post_image.attach(io: File.open('spec/fixtures/free_user.png'), filename: 'free_user.png', content_type: 'image/jpg')
    end
  end
end