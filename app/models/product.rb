class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :burden
  belongs_to :from_area
  belongs_to :delivery_days
  belongs_to :condition
  belongs_to :brand
  accepts_nested_attributes_for :brand
end
