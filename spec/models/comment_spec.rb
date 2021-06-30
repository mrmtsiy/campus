require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = build(:comment)
  end
  describe "#create" do
    context "コメント投稿できる場合" do
      it "コメント入力済みならパス" do
        expect(@comment).to be_valid
      end
      it "100文字以内ならパス" do
        @comment = build(:comment, comment: "a" * 100)
        expect(@comment).to be_valid
      end
    end

    context "コメント投稿できない場合" do
      it "コメントが空白なら失敗" do
        @comment = build(:comment, comment: nil)
        @comment.valid?
        expect(@comment).to be_invalid
      end
      it "101文字以上なら失敗" do
        @comment = build(:comment, comment: "a" * 101)
        expect(@comment).to be_invalid
      end

      it "ユーザーが紐づいていなければ失敗" do
        @comment.user = nil
        expect(@comment).to be_invalid
      end
    end
  end
end
