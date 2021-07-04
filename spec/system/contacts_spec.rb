require 'rails_helper'

RSpec.describe 'お問い合わせ送信', type: :system do
  before do
    @contact = FactoryBot.build(:contact)
  end

  context 'お問い合わせの送信ができるとき' do
    it '正しい情報を入力すれば、お問い合わせを送信できる' do
      visit root_path
      expect(page).to have_content('お問い合わせ')
      visit new_contacts_path
      fill_in 'お名前', with: @contact.name
      fill_in 'メールアドレス', with: @contact.email
      fill_in '内容', with: @contact.content
      expect do
        find('input[name="commit"]').click
      end.to change { Contact.count }.by(1)
      expect(current_path).to eq thanks_contacts_path
      click_link 'トップページへ戻る'
      expect(current_path).to eq root_path
    end
  end

  context 'お問い合わせの送信ができないとき' do
    it '正しい情報を入力しなければ、お問い合わせは送信できない' do
      visit root_path
      expect(page).to have_content('お問い合わせ')
      visit new_contacts_path
      fill_in 'お名前', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in '内容', with: ''
      expect do
        find('input[name="commit"]').click
      end.to change { Contact.count }.by(0)
      expect(current_path).to eq contacts_path
    end
  end
end