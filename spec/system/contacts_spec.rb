require 'rails_helper'

RSpec.describe 'お問い合わせ送信', type: :system do

    let!(:user) { create(:user) }
    let!(:contact) { create(:contact) }

    before do
      login(user)
    end

  context 'お問い合わせの送信ができるとき' do
    it '正しい情報を入力すれば、お問い合わせを送信できる' do
      visit new_contact_path
      fill_in '名前', with: contact.name
      fill_in 'お問い合わせ内容', with: contact.message
      click_button "送信"
      expect(current_path).to eq contact_thanks_path(contact)
      click_link 'トップページへ戻る'
      expect(current_path).to eq root_path
    end
  end

  context 'お問い合わせの送信ができないとき' do
    it '正しい情報を入力しなければ、お問い合わせは送信できない' do
      visit new_contact_path
      fill_in '名前', with: ''
      fill_in 'お問い合わせ内容', with: ''
      expect do
        find('input[name="commit"]').click
      end.to change { Contact.count }.by(0)
      expect(current_path).to eq new_contact_path
    end
  end
end