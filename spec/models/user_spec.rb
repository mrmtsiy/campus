require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  # ユーザー名、メール、パスワードがあれば有効な状態であること
  it "is valid with a username, email, password, and password_comfirm" do
    expect(user).to be_valid
  end
  # 名がなければ無効な状態であること
  it "is invalid without a username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("が入力されていません。")
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(
      username: "morimoto",
      email: "test@example.com",
      password: "testpass",
      encrypted_password: "testpass",
    )
    user = User.new(
      username: "morimoto",
      email: "test@example.com",
      password: "testpass",
      encrypted_password: "testpass",
    )
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end
end
