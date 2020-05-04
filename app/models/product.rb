class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :burden
  belongs_to :from_area
  belongs_to :delivery_days
  belongs_to :condition
  belongs_to :brand, dependent: :destroy

  belongs_to :category
  accepts_nested_attributes_for :brand

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  
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
