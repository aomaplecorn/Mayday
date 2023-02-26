# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  [
    {email: 'admin1@test.mayday', password: 'admin1'}
  ]
)

artists = Artist.create!(
  [
    # ゲストユーザー
    {email: 'aaa@test.mayday',password: 'password', name: 'ゲスト（アーティスト）', telephone_number: '00012345678', is_deleted: 'false', introduction: ''},
    # テストデータ
    {email: 'redif@test.mayday', password: 'password', name: 'redif', telephone_number: '11123456789', delivery_cost: 500 , is_deleted: 'false',
    introduction: 'イギリスのリバプール出身５人組で構成された新進気鋭ロックバンド「The Red if」　Gt.Vo：John　Gt：Oliver　Ba：George　Dr：Harry　Ke：Noah　Johnから一言：日本の皆さんに会えて光栄です。ライブで一緒に叫ぼう。',
      background_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-background-image1.jpg"), filename:"test-background-image1.jpg"),
      introduction_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-artist1.jpg"), filename:"test-artist1.jpg")},

    {email: 'kamisuki@test.mayday', password: 'password', name: '紙透 光太郎', telephone_number: '11123456789', delivery_cost: 350 , is_deleted: 'false',
      introduction: '大学生になってまもない頃、道端に落ちてるアコギを拾い音楽に目覚めてからずっとシンガーソングライターやってます！たまに岡山のパパツーでライブやってます！よかったら楽曲聴いてってください',
      background_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-background-image2.jpg"), filename:"test-background-image2.jpg"),
      introduction_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-artist2.jpg"), filename:"test-artist2.jpg")},

    {email: 'ys0624@test.mayday', password: 'password', name: 'Yuri Shiraki', telephone_number: '11123456789', delivery_cost: 400 , is_deleted: 'false',
      introduction: 'みなさんこんにちは、Yuri Shirakiです。普段は新宿のジャズバーでピアノを弾いています。趣味は旅行で、背景の星空は長野で撮ったものです。よかったらピアノ聴きにきてくださいねヽ(*＾ω＾*)ﾉ',
      background_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-background-image3.jpg"), filename:"test-background-image3.jpg"),
      introduction_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-artist3.jpg"), filename:"test-artist3.jpg")}
  ]
)

customers = Customer.create!(
  [
    # ゲストユーザー
    {email: 'aaa@test.mayday', password: 'password', name: 'ゲスト（一般会員）', name_kana: 'ゲストイッパンカイイン', postal_code: '1234567', address: '住所', telephone_number: '00012345678', is_deleted: 'false'},
    # テストデータ
    {email: 'nemunoki@test.mayday', password: 'password', name: '合歓木 優', name_kana: 'ネムノキユウ', postal_code: '1112345', address: '北海道富良野市メーデー2-10 めいでい302', telephone_number: '01012345678', is_deleted: 'false'},
    {email: 'kuwamori@test.mayday', password: 'password', name: '鍬守 健', name_kana: 'クワモリタケル', postal_code: '1112345', address: '岡山県倉敷市メーデー6-10 めいでい101', telephone_number: '01012345678', is_deleted: 'false'},
    {email: 'warabino@test.mayday', password: 'password', name: '蕨野 翔太', name_kana: 'ワラビノショウタ', postal_code: '1112345', address: '東京都新宿区メーデー5-20 めいでい501', telephone_number: '01012345678', is_deleted: 'false'}
  ]
)

albums = Album.create!(
  [
    {id: 3, name: 'Still In Love', price: 1000, released: true, artist_id: artists[2].id,
      jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-album-image2.jpg"), filename:"test-album-image2.jpg") },
    {id: 4, name: 'In That Mood', price: 1200, released: true, artist_id: artists[3].id,
      jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-album-image4.jpg"), filename:"test-album-image4.jpg") },
    {id: 5, name: 'Date time', price: 1100, released: true, artist_id: artists[3].id,
      jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-album-image5.jpg"), filename:"test-album-image5.jpg") },
    {id: 2, name: 'makiba no kaze', price: 800, released: true, artist_id: artists[2].id,
      jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-album-image3.jpg"), filename:"test-album-image3.jpg") },
    {id: 1, name: 'Storm', price: 1500, released: true, artist_id: artists[1].id,
      jacket_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-album-image1.jpg"), filename:"test-album-image1.jpg") }
  ]
)

Music.create!(
  [
    {name: 'power', track: 1, index_info: '作詞・作曲：Redif', artist_id: artists[1].id, album_id: albums[4].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tikara ga minagiru.mp3"), filename:"tikara ga minagiru.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tikara ga minagiru-demo.mp3"), filename:"tikara ga minagiru-demo.mp3") },
    {name: 'Teeth', track: 2, index_info: '作詞・作曲：Redif', artist_id: artists[1].id, album_id: albums[4].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Teeth.mp3"), filename:"Teeth.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Teeth-demo.mp3"), filename:"Teeth-demo.mp3") },

    {name: 'Still In Love', track: 1, index_info: 'コーヒー片手にStill In Loveを聴いてみるのはどうですか？', artist_id: artists[2].id, album_id: albums[0].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Still In Love.mp3"), filename:"Still In Love.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Still In Love-demo.mp3"), filename:"Still In Love-demo.mp3") },
    {name: 'hokkori tea time', track: 2, index_info: 'ゆったりとした曲調。よく行くカフェで作曲した曲です。', artist_id: artists[2].id, album_id: albums[0].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hokkori tea time.mp3"), filename:"hokkori tea time.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/hokkori tea time-demo.mp3"), filename:"hokkori tea time-demo.mp3") },
    {name: 'Someday in the Rain', track: 3, index_info: '作業曲としておすすめです。', artist_id: artists[2].id, album_id: albums[0].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Someday in the Rain.mp3"), filename:"Someday in the Rain.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Someday in the Rain-demo.mp3"), filename:"Someday in the Rain-demo.mp3") },

    {name: 'yousei no mori', track: 1, index_info: 'カントリーに初挑戦した曲です！ちょっとポップすぎるかな？と思ってます', artist_id: artists[2].id, album_id: albums[3].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yousei no mori.mp3"), filename:"yousei no mori.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/yousei no mori-demo.mp3"), filename:"yousei no mori-demo.mp3") },
    {name: 'makiba no kaze', track: 2, index_info: '愉快なカントリー曲として作ってみました', artist_id: artists[2].id, album_id: albums[3].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/makiba no kaze.mp3"), filename:"makiba no kaze.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/makiba no kaze-demo.mp3"), filename:"makiba no kaze-demo.mp3") },

    {name: 'In That Mood', track: 1, index_info: '夜のデートのムード作りに最適です❤︎', artist_id: artists[3].id, album_id: albums[1].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/In That Mood.mp3"), filename:"In That Mood.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/In That Mood-demo.mp3"), filename:"In That Mood-demo.mp3") },
    {name: 'Let It Happen', track: 2, index_info: '眠る前のヒーリングミュージックとして聴いてみてください❤︎', artist_id: artists[3].id, album_id: albums[1].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Let It Happen.mp3"), filename:"Let It Happen.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Let It Happen-demo.mp3"), filename:"Let It Happen-demo.mp3") },

    {name: 'Daytime activity', track: 1, index_info: '昼間のドライブデートにオススメです❤︎', artist_id: artists[3].id, album_id: albums[2].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Daytime activity.mp3"), filename:"Daytime activity.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Daytime activity-demo.mp3"), filename:"Daytime activity-demo.mp3") },
    {name: 'Special To Me', track: 2, index_info: 'ジャズバーでよく弾く好きな曲の一つです❤︎', artist_id: artists[3].id, album_id: albums[2].id,
      audio: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Special To Me.mp3"), filename:"Special To Me.mp3"),
      test_audio:  ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Special To Me-demo.mp3"), filename:"Special To Me-demo.mp3") }
  ]
)

Item.create!(
  [
    {name: 'サイト応援Tシャツ', introduction: 'いつもお世話になっているMaydayさんへの応援Tシャツです！', amount: 20, price: 1500, is_active: true, artist_id: artists[2].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image3.jpg"), filename:"test-item-image3.jpg") },
    {name: 'スマホケース', introduction: 'なぜこれを作ったのか自分でもわからない！大学の友達とお試しで作ったのでよければぜひどうぞ！対応機種：ipon13,ipon14', amount: 5, price: 3000, is_active: true, artist_id: artists[2].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image4.jpg"), filename:"test-item-image4.jpg") },
    {name: 'しるくとーと', introduction: 'まるでシルク生地！？と思わせるような、優しい肌触りのトートバッグです。ワンピによく合う！', amount: 5, price: 3000, is_active: true, artist_id: artists[3].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image6.jpg"), filename:"test-item-image6.jpg") },
    {name: 'オーバーサイズパーカー', introduction: 'オーバーサイズで何にでも合う真っ白パーカー作ってみました！サイズ：フリー、色：白のみ', amount: 10, price: 4500, is_active: true, artist_id: artists[3].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image5.jpg"), filename:"test-item-image5.jpg") },
    {name: 'Redif限定Tシャツ', introduction: 'The Red if限定のオリジナルTシャツ！ぜひお買い求めください！', amount: 30, price: 2000, is_active: true, artist_id: artists[1].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image1.jpg"), filename:"test-item-image1.jpg") },
    {name: 'Redif限定トートバッグ', introduction: 'The Red if限定のオリジナルTシャツ！ぜひお買い求めください！', amount: 10, price: 3500, is_active: true, artist_id: artists[1].id,
      item_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-item-image2.jpg"), filename:"test-item-image2.jpg") },
  ]
)
