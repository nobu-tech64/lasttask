class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :postal_code, :prefecture, :city, :address, :building, :phone_number ,presence: true
end
