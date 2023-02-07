class Music < ApplicationRecord

  # モデルの関係
  belongs_to :artist
  belongs_to :album

  # 音楽ファイル
  has_one_attached :audio
  has_one_attached :test_audio

  # バリデーション
  validates :name, presence: true

  # 音楽ファイルの確認
  def get_audio
    unless audio.attached?
      file_path = Rails.root.join('app/assets/audios/default-audio.mp3')
      audio.attach(io: File.open(file_path),filename: 'default-audio.mp3',content_type: 'audio/mp3')
    end
    audio
  end

  # 音楽ファイル（試聴用）の確認
  def get_test_audio
    unless test_audio.attached?
      file_path = Rails.root.join('app/assets/audios/default-test-audio.mp3')
      test_audio.attach(io: File.open(file_path),filename: 'default-test-audio.mp3',content_type: 'audio/mp3')
    end
    test_audio
  end


end
