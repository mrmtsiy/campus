require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe "Post CRUD" do
    let(:user) { create(:user) }
    let(:post) { create(:post)}

    describe "ログイン前" do
      describe "投稿機能" do
        it "ログイン画面へ遷移される" do
          #投稿ページに遷移
          visit new_post_path
          # ログイン画面に遷移される
          expect(current_path).to eq new_user_session_path
          # flashメッセージ　'ログインもしくはアカウント登録してください。'
          expect(page).to have_content 'ログインもしくはアカウント登録してください。'
        end
      end

      describe "投稿編集機能" do
        it "ログイン画面へ遷移される" do
          #投稿編集ページに遷移
          visit edit_post_path(post)
          # ログイン画面に遷移される
          expect(current_path).to eq new_user_session_path
          # flashメッセージ　'ログインもしくはアカウント登録してください。'
          expect(page).to have_content 'ログインもしくはアカウント登録してください。'
        end
      end

      describe "投稿の削除" do
        it "ログイン画面へ遷移される" do
          #投稿編集ページに遷移
          visit edit_post_path(post)
          # ログイン画面に遷移される
          expect(current_path).to eq new_user_session_path
          # flashメッセージ　'ログインもしくはアカウント登録してください。'
          expect(page).to have_content 'ログインもしくはアカウント登録してください。'
        end
      end
    end

    describe "ログイン後" do
      # ログインする
      before do
        login(user)
      end
      context "投稿機能" do
        it "成功" do
          # 投稿画面に遷移する
          visit new_post_path
          # 投稿する画像を選択
          attach_file "post[post_image]", "spec/fixtures/free_user.png"
          # タイトルを記入
          fill_in "タイトル",	with: post.title
          # 内容を記入
          fill_in "内容",	with: post.content
          # タグを記入
          fill_in "タグ", with: "tag"
          # 投稿ボタンをクリック
          click_on "投稿する"
          # 投稿一覧ページに遷移していることを確認
          expect(current_path).to eq posts_path
          # flashメッセージ "投稿に成功しました"
          expect(page).to have_content '投稿に成功しました'
          #投稿詳細ページに遷移する
          visit post_path(post)
          # 詳細ページに反映されているか確認
          expect(page).to have_content "camp"
          expect(page).to have_content "enjoy"
          expect(page).to have_content "tag"
        end

        it "失敗" do
          # 投稿画面に遷移する
          visit new_post_path
          # 投稿する画像を選択
          attach_file "post[post_image]", "spec/fixtures/free_user.png"
          # タイトルを記入
          fill_in "タイトル",	with: nil
          # 内容を記入
          fill_in "内容",	with: post.content
          # タグを記入
          fill_in "タグ", with: "tag"
          # 投稿ボタンをクリック
          click_on "投稿する"
          # flashメッセージ "投稿に成功しました"
          expect(page).to have_content '必須項目を記入して下さい'
        end
      end

      context "投稿編集機能" do
        it "成功" do
          # 投稿編集画面に遷移する
          visit edit_post_path(post)
          # タイトルを記入
          fill_in "タイトル",	with: "change1"
          # 内容を記入
          fill_in "内容",	with: "change2"
          # タグを記入
          fill_in "タグ", with: "change3"
          # 投稿ボタンをクリック
          click_on "更新する"
          # 投稿一覧ページに遷移していることを確認
          expect(current_path).to eq posts_path
          # flashメッセージ "投稿に成功しました"
          expect(page).to have_content '投稿内容を変更しました'
          #投稿詳細ページに遷移する
          visit post_path(post)
          # 詳細ページに反映されているか確認
          expect(page).to have_content "change1"
          expect(page).to have_content "change2"
          expect(page).to have_content "change3"
        end

        it "失敗" do
          # 投稿編集画面に遷移する
          visit edit_post_path(post)
          # タイトルを記入
          fill_in "タイトル",	with: nil
          # 内容を記入
          fill_in "内容",	with: post.content
          # タグを記入
          fill_in "タグ", with: "tag"
          # 投稿ボタンをクリック
          click_on "更新する"
          # flashメッセージ "投稿に成功しました"
          expect(page).to have_content 'タイトルと内容を記入してください'
        end
      end

      context "投稿削除機能" do
        it "投稿を削除する" do
          # 投稿編集画面に遷移する
          visit edit_post_path(post)
          # 削除ボタンをクリック
          click_on "削除"
          #投稿一覧に遷移する
          expect(current_path).to eq posts_path
          # flashメッセージ　"投稿を削除しました"
          expect(page).to have_content '投稿を削除しました'
        end
      end
      

    end
    
  end
  
end
