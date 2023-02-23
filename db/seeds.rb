# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  [
    {email: 'admin1@test.com', password: 'admin1'}
  ]
)

artists = Artist.create!(
  [
    {email: 'redif@test.com', password: 'password', name: 'redif', telephone_number: '11123456789', is_deleted: 'false', introduction: '僕らは音楽を始めた',
    background_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-background-image1.jpg"), filename:"sample-background-image1.jpg"),
    introduction_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-artist1.jpg"), filename:"sample-artist1.jpg")},
  ]
)

customers = Customer.create!(
  [
    {email: 'kotarou1@test.com', password: 'password', name: '小太郎', name_kana: 'コタロウ', postal_code: '1112345', address: '東京都新宿区メーデー5-20 めいでい５０１', telephone_number: '01012345678', is_deleted: 'false'}
  ]
)

albums = Album.create!(
  [
    {name: 'Storm Rock', price: 1500, released: true, artist_id: artists[0].id,
    jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-album-image1.jpg"), filename:"sample-album-image1.jpg") }
  ]
)

Music.create!(
  [
    {name: 'the power', track: 1, index_info: '作詞・作曲：Redif', artist_id: artists[0].id, album_id: albums[0].id,
    audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tikara ga minagiru.mp3"), filename:"tikara ga minagiru.mp3"),
    test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tikara ga minagiru-demo.mp3"), filename:"tikara ga minagiru-demo.mp3") }
  ]
)

Item.create!(
  [
    {name: 'redif限定Tシャツ', introduction: 'Redif限定のオリジナルTシャツ！ぜひお買い求めください！', amount: 10, price: 1000, is_active: true, artist_id: artists[0].id,
    item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-item-image1.jpg"), filename:"sample-item-image1.jpg") }
  ]
)

# 以下は未テスト
# orders = Order.create!(
#   [
#     {customer_id: customers[0].id}
#   ]
# )

# OrderDetail!(
#   [
#     {}
#   ]
# )