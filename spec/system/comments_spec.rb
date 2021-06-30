require 'rails_helper'

RSpec.describe "Comments", type: :system do

  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment) }

  describe "コメント機能" do
    context "ログイン前" do
      it "ログイン画面へ遷移される" do
        # postのコメント投稿画面へ遷移
        visit new_post_comment_path(post)
        # ログイン画面へ遷移される
        expect(current_path).to eq new_user_session_path
      end
    end
    
    context "ログイン後" do
    # ログインする
      before do
        login(user)
      end

      it "100文字以内ならコメント成功" do
        # postのコメント投稿画面へ遷移
        visit new_post_comment_path(post)
        # コメント(:comment)を記入する
        fill_in "comment[comment]",	with: comment.comment
        # 送信ボタンをクリックする
        click_on "送信"
        # 投稿詳細ページに遷移しているか確認する
        expect(current_path).to eq post_path(post)
        # 投稿したコメントがあるか確認する
        expect(page).to have_content "コメントです"
      end

      it "100文字以上ならコメント失敗" do
        # postのコメント投稿画面へ遷移
        visit new_post_comment_path(post)
        # コメントを101文字記入する
        fill_in "comment[comment]",	with: "a" * 101
        # 送信ボタンをクリックする
        click_on "送信"
        # コメント投稿ページにいるか確認
        expect(current_path).to eq new_post_comment_path(post)
        # flashメッセージ "コメントを入力してください(1~100文字以内)"
        expect(page).to have_content "コメントを入力してください(1~100文字以内)"
      end

      it "コメントがnilならコメント失敗" do
        # postのコメント投稿画面へ遷移
        visit new_post_comment_path(post)
        # コメントを101文字記入する
        fill_in "comment[comment]",	with: nil
        # 送信ボタンをクリックする
        click_on "送信"
        # コメント投稿ページにいるか確認
        expect(current_path).to eq new_post_comment_path(post)
        # flashメッセージ "コメントを入力してください(1~100文字以内)"
        expect(page).to have_content "コメントを入力してください(1~100文字以内)"
      end
    end
    
  end
  

end