require 'rails_helper'

RSpec.describe "Follows", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

    describe '#create,#destroy' do
        it 'ユーザーをフォロー、フォロー解除できる' do
            # @user1としてログイン
            sign_in(@user1)

            # @user2のユーザー詳細ページに遷移
            visit user_path(@user2)

            # @user2をフォローする
            click_link 'フォローする'
            expect(page).to have_selector '.unfollow-button'
            expect(@user1.followings.count).to eq(1)
            expect(@user2.followers.count).to eq(1)

            # @user2をフォロー解除する
            click_link 'フォローを解除する'
            expect(page).to have_selector '.follow-button'
            expect(@user1.followings.count).to eq(0)
            expect(@user2.followers.count).to eq(0)
        end
    end
end