require 'rails_helper'

RSpec.describe "Likes", type: :system do

  #   let!(:user1) { create(:user, username: 'ユーザー1') }
  #   let!(:user2) { create(:user, username: 'ユーザー2') }
  #   let!(:post) { create(:post, user: user2) }

  # describe "#create, #destroy" do

  #   it "ログイン済みなら投稿詳細ページから他人の投稿にいいねできる" do
  #     # user1としてログイン
  #     sign_in(user1)
  #     # 投稿の詳細ページに遷移
  #     visit post_path(post)
  #     # 投稿にいいねをする
  #     find("#like-btn").click
  #     expect(page).to have_selector '#unlike-btn'
  #     expect(post.liked_users.count).to eq 1
  #     # いいねを解除する
  #     find("#unlike-btn").click
  #     expect(page).to have_selector '#like-btn'
  #     expect(post.liked_users.count).to eq(0)
  #   end
  # end
  
end
