require 'rails_helper'

RSpec.describe Follow, type: :model do
  before do
    # ユーザー2名を事前に生成して登録
    @user = create(:user)
    @another_user = create(:user)
    # app/models/user.rbで定義したfollowメソッド（友達申請）の実行結果を変数@relationshipに代入
    @relationship = @user.follow(@another_user)
  end

  describe '#create' do
    context '成功' do
      it 'is valid with follower_id, followed_id' do
        expect(@relationship).to be_valid
      end
    end

    context '失敗' do
      # 友達申請する側の値（follower_id）がなければ保存できない。
      it 'is invalid without follower_id(active relationship)' do
        @relationship.user_id = ''
        @relationship.valid?
        expect(@relationship).to be_invalid
      end
      # 友達申請される側の値（followed_id）がなければ保存できない。
      it 'is invalid without followed_id(passive relationship' do
        @relationship.target_user_id = ''
        @relationship.valid?
        expect(@relationship).to be_invalid
      end
      # 同じ組み合わせの友達申請のデータがすでに保存されている場合は保存できない
      it 'is invalid with duplicate relationship' do
        @relationship.save
        # @relationshipとは別のレコードとしてanother_relationshipを用意
        another_relationship = @user.follow(@another_user)
        # another_relationshipに@relationshipと同じ値を代入
        another_relationship.user_id = @relationship.user_id
        another_relationship.target_user_id = @relationship.target_user_id
        another_relationship.valid?
        expect(another_relationship).to be_invalid
      end
    end
  end
end
