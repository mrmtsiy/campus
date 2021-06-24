require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'TOPページに「私達のもうひとつのライフスタイル」が含まれている' do
    # root_pathへアクセス
    visit root_path
    # ページ内に'Hello World!'が含まれているかを検証
    expect(page).to have_content '私達のもうひとつのライフスタイル'
  end
end