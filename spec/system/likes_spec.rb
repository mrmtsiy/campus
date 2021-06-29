require 'rails_helper'

RSpec.describe "Likes", type: :system do

    let!(:user1) { create(:user, username: 'ユーザー1') }
    let!(:user2) { create(:user, username: 'ユーザー2') }
    let!(:post) { create(:post, user: user2) }
  describe "#create, #destroy" do

    it "ログイン済みなら投稿詳細ページから他人の投稿にいいねできる" do
      # user1としてログイン
      sign_in(user1)
      # 投稿の詳細ページに遷移
      visit post_path(post)
      # 投稿にいいねをする
      find("#like-btn").click
      #いいねボタンのセレクターが '.unlike-btn'になったことを確認する
      expect(page).to have_selector('.unlike-btn')
      # いいねを解除する
      find("#like-btn").click
      #いいねボタンのセレクターが'.like-btn'になったことを確認する
      expect(page).to have_selector('.like-btn')
    end
  end
  
end
