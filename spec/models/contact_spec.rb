require 'rails_helper'

RSpec.describe Contact, type: :model do
  before do
    @contact = FactoryBot.build(:contact)
  end

  describe 'お問い合わせの送信' do
    context 'お問い合わせが送信できる場合' do
      it '全ての要素が存在すれば投稿できる' do
        expect(@contact).to be_valid
      end
    end
    context 'お問い合わせが送信できない場合' do
      it 'nameが空では送信できない' do
        @contact.name = nil
        @contact.valid?
        expect(@contact.errors.full_messages).to include('お名前を入力してください')
      end
      it 'emailが空では送信できない' do
        @contact.email = nil
        @contact.valid?
        expect(@contact.errors.full_messages).to include('メールアドレスを入力してください')
      end
      it 'contentが空では送信できない' do
        @contact.content = nil
        @contact.valid?
        expect(@contact.errors.full_messages).to include('お問い合わせ内容を入力してください')
      end
    end
  end
end