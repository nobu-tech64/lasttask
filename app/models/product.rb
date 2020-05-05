class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :burden, optional: true
  belongs_to :from_area, optional: true
  belongs_to :delivery_days, optional: true
  belongs_to :condition, optional: true
  belongs_to :brand, optional: true, dependent: :destroy

  belongs_to :category, optional: true
  accepts_nested_attributes_for :brand

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id', optional: true
  
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, length: { maximum: 1000 }

  validates_associated :images
  validates :images, presence: true

  validates :condition_id, presence: true
  validates :burden_id, presence: true
  validates :from_area_id, presence: true
  validates :delivery_days_id, presence: true

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}, presence: true
end
