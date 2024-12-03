class User < ApplicationRecord
  has_many :items
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
          validates :nickname, presence: true
          validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must contain @ and be valid" }
          validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "must include both letters and numbers" }, confirmation: true
          validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "must be full-width characters" }
          validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "must be full-width characters" }
          validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
          validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "must be full-width katakana characters" }
          validates :birth_date, presence: true
end
