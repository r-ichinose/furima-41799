class User < ApplicationRecord
  has_many :items
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
          validates :nickname, presence: true
          validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "must include both letters and numbers" }
          validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be full-width characters" }
          validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be full-width characters" }
          validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "must be full-width katakana characters" }
          validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "must be full-width katakana characters" }
          validates :birth_date, presence: true
end
