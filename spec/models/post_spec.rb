require 'rails_helper'

RSpec.describe Post, type: :model do
  context "titleカラム" do
  #postのタイトル空欄でないこと
    it "空欄の場合、失敗する" do
      @post = build(:post, title: '')
      expect(@post.valid?).to eq(false)
    end
  end

  context "contentカラム" do
  #postの内容がないと無効
    it "空欄の場合、失敗する" do
      @post = build(:post, content: '')
      expect(@post.valid?).to eq(false)
    end
  end

  context "post_imageカラム" do
  #postの写真がないと無効
    it "選択されていない場合、失敗する" do
      @post = build(:post, post_image: nil)
      expect(@post.valid?).to eq(false)
    end
  end
end