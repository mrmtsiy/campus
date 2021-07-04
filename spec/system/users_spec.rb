require 'rails_helper'

RSpec.describe "Users", js: true, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "User CRUD" do
    describe "ログイン前" do
      describe "ユーザーの新規登録" do
        context "フォームの入力値が正常" do
          it "新規登録が成功する" do
            # 新規登録画面へ遷移する
            visit new_user_registration_path
            # Usernameテキストフィールドにusernameを入力
            fill_in "ユーザー名",	with: "testuser"
            # Emailテキストフィールドにemailを入力
            fill_in "メールアドレス",	with: "test@test.com"
            # Passwordテキストフィールドにlet(:user)に定義したユーザーデータのpasswordを入力
            fill_in "新規パスワード",	with: "testpass"
            # Password confirmationテキストフィールドにpasswordを入力
            fill_in "確認用パスワード",	with: "testpass" 
            # 新規登録ボタンをクリックする
            click_button "新規登録"
            # root_pathへ遷移することを期待する
            expect(current_path).to eq root_path
            # 遷移されたページに'User was successfully created.'の文字列があることを期待する
            expect(page).to have_content 'アカウント登録が完了しました。'
          end
        end

        context "emailが未入力" do
          it "新規登録が失敗する" do
            # 新規登録画面へ遷移する
            visit new_user_registration_path
            # Usernameテキストフィールドにusernameを入力
            fill_in "ユーザー名",	with: "testuser" 
            # Emailテキストフィールドをnil状態にする
            fill_in "メールアドレス",	with: nil
            # Passwordテキストフィールドにlet(:user)に定義したユーザーデータのpasswordを入力
            fill_in "新規パスワード",	with: "testpass"
            # Password confirmationテキストフィールドにpasswordを入力
            fill_in "確認用パスワード",	with: "testpass" 
            # 新規登録ボタンをクリックする
            click_button "新規登録"
            # root_pathへ遷移することを期待する
            expect(current_path).to eq users_path
            # 遷移されたページに'メールアドレスが入力されていません。'の文字列があることを期待する
            expect(page).to have_content 'メールアドレスが入力されていません。'
          end
        end

        context "登録済みのメールアドレス" do
          it "新規登録が失敗する" do
            # 新規登録画面へ遷移する
            visit new_user_registration_path
            # Usernameテキストフィールドにlet(:user)に定義したユーザーデータのusernameを入力
            fill_in "ユーザー名",	with: "testuser" 
            # Emailテキストフィールドにlet(:user)に定義したユーザーデータのemailを入力
            fill_in "メールアドレス",	with: user.email
            # Passwordテキストフィールドにlet(:user)に定義したユーザーデータのpasswordを入力
            fill_in "新規パスワード",	with: "testpass"
            # Password confirmationテキストフィールドにpasswordを入力
            fill_in "確認用パスワード",	with: "testpass" 
            # 新規登録ボタンをクリックする
            click_button "新規登録"
            # root_pathへ遷移することを期待する
            expect(current_path).to eq users_path
            # 遷移されたページに'メールアドレスは既に使用されています。'の文字列があることを期待する
            expect(page).to have_content 'メールアドレスは既に使用されています。'
          end
        end
      end
    end

    describe "ログイン後" do
      before do
        #ログインする
        login(user)
      end
      describe "ユーザーの編集" do
        context "フォームの入力値が正常" do
          it "ユーザーの編集が成功" do
            visit edit_user_registration_path(user)
            fill_in 'ユーザー名', with: 'testkun'
            click_button '更新する'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content 'アカウント情報を変更しました'
          end
        end

        context "emailが未入力" do
          it "ユーザーの編集が失敗" do
            visit edit_user_registration_path(user)
            fill_in 'ユーザー名', with: nil
            click_button '更新する'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Usernameが入力されていません。'
          end
        end

        context "アカウント削除処理" do
          it "ユーザーを削除する" do
            #ユーザー編集画面へ遷移
            visit edit_user_registration_path(user)
            #ユーザー削除ボタンをクリック
            click_link "削除"
            expect{
              expect(page.accept_confirm).to eq '本当に削除してよろしいですか？'
              expect(page).to have_content "アカウントを削除しました"
            }
          end
        end

      end
    end

    describe "ゲストユーザー機能" do
      before do
        #ゲストユーザーでログインする
        visit new_user_session_path
        click_on "ゲストログイン（閲覧用）"
      end

      it "ゲストユーザーでログイン" do
        #現在のページがroot_pathか確認
        expect(current_path).to eq root_path
        #flashメッセージ "ゲストユーザーとしてログインしました。"
        expect(page).to have_content 'ゲストユーザーとしてログインしました。'
      end

      it "ゲストユーザーの削除失敗" do
        #ユーザー編集画面へ遷移
        visit edit_user_registration_path(user)
        #削除ボタンをクリック
        click_on "削除"
        #flashメッセージ "ゲストユーザーの更新・削除はできません。"
        expect(page).to have_content 'ゲストユーザーの更新・削除はできません。'
      end

      it "ゲストユーザーの編集失敗" do
        #ユーザー編集画面へ遷移
        visit edit_user_registration_path(user)
        #名前を変更
        fill_in "ユーザー名",	with: nil
        #更新ボタンをクリック
        click_on "更新する"
        #flashメッセージ "ゲストユーザーの更新・削除はできません。"
        expect(page).to have_content 'ゲストユーザーの更新・削除はできません。'
      end
    end
  end
end
