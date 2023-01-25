class Music < ApplicationRecord

  # モデルの関係
  belongs_to :artist
  belongs_to :album

  # 音楽ファイル
  has_one_attached :audio

  # バリデーション
  validates :name, presence: true
  validates :price, presence: true

  # 音楽ファイルの確認
  def get_audio
    unless audio.attached?
      file_path = Rails.root.join('app/assets/audios/default-audio.mp3')
      audio.attach(io: File.open(file_path),filename: 'default-audio.mp3',content_type: 'audio/mp3')
    end
    audio
  end


end
