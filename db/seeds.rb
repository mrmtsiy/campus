# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

gear = Category.create(name: 'ギア')
tent_tarp, sleeping, furniture, cooler, heating, light, cooking, tool = gear.children.create(
  [
    { name: 'テント, タープ' },
    { name: 'スリーピング' },
    { name: 'ファニチャー' },
    { name: 'クーラーボックス' },
    { name: 'ヒーティング' },
    { name: 'ライト' },
    { name: '調理器具' },
    { name: 'ツール' }
  ]
)

['テント', 'タープ', 'ペグ', 'ポール'].each do |name|
  tent_tarp.children.create(name: name)
end

['シュラフ', 'ベット', 'コット', 'マット', '枕'].each do |name|
  sleeping.children.create(name: name)
end

['チェア', 'テーブル', 'ラック', 'セット', 'ベンチ', 'ハンモック'].each do |name|
  furniture.children.create(name: name)
end

['クーラーボックス'].each do |name|
  cooler.children.create(name: name)
end

['バーナー', 'グリル', '焚き火台', 'ストーブ', '燃料', '薪', 'スモーカー', 'コンロ'].each do |name|
  heating.children.create(name: name)
end

['ランタン', 'LED'].each do |name|
  light.children.create(name: name)
end

[
  '鍋',
  'フライパン',
  'コップ',
  'カップ',
  'シェラカップ',
  'マグ',
  '皿',
  'ナイフ',
  'フォーク',
  'スプーン',
  'まな板',
  '包丁',
  '調味料',
  'ケトル',
  'ダッチオーブン',
  'スキレット',
  'ホットサンドメーカー'
].each do |name|
  cooking.children.create(name: name)
end

['ハンマー', 'ナイフ', 'マルチツール', '火起こし', 'キャリーカート', '斧', 'バックパック'].each do |name|
  tool.children.create(name: name)
end
