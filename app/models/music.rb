class Music < ApplicationRecord

  # モデルの関係
  belongs_to :artist
  belongs_to :album

  # 音楽ファイル
  has_one_attached :audio

  # バリデーション
  validates :name, presence: true
  validates :price, presence: true





end
