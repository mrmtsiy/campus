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
        expect(page).to have_content('お問い合わせの送信に失敗しました')
      end

      it 'messageが空では送信できない' do
        @contact.message = nil
        @contact.valid?
        expect(page).to have_content('お問い合わせの送信に失敗しました')
      end
    end
  end
end