class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :burden
  belongs_to :from_area
  belongs_to :delivery_days
  belongs_to :condition
  belongs_to :brand
  accepts_nested_attributes_for :brand
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
end
