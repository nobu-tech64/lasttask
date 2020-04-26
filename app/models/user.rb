class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         kanjihira = /\A[一-龥ぁ-ん]/
         kana = /\A([ァ-ン]|ー)+\z/
         year_month_day = /\A\d{4}-\d{2}-\d{2}\z/


  validates :nickname, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true, format: { with: kanjihira }
  validates :last_name, presence: true, format: { with: kanjihira }
  validates :first_name_kana, presence: true, format: { with: kana }
  validates :last_name_kana, presence: true, format: { with: kana }
  has_one :address
  has_many :cards
end
