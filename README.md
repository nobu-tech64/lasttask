# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## user
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|encrypted_password|string|null: false|
### Association
- has_one :address, dependent: :destroy
- has_one :profile, dependent: :destroy
- has_one :creditcard, dependent: :destroy
- has_one :seller, dependent: :destroy
- has_one :buyer, dependent: :destroy
- has_many :product, dependent: :destroy

## address
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_ruby|string|null: false|
|last_name_ruby|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|null: false|
### Association
- belongs_to :user

## creditcard
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|card_id|string|null: false|
|customer_id|string|null: false|
### Association
- belongs_to :user

## profile
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_ruby|string|null: false|
|last_name_ruby|string|null: false|
|birthyear|integer|null: false|
|birthmonth|integer|null: false|
|birthday|integer|null: false|
### Association
- belongs_to :user

## product
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|discription|text|null: false|
|size|string|null: false|
|condition|string|null: false|
### Association
- belongs_to :user
- has_one :seller, dependent: :destroy
- has_one :buyer, dependent: :destroy
- has_many :image, dependent: :delete_all
- has_many :product_category, dependent: :destroy

## image
|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|image|string|null: false|
### Association
- belongs_to :product, optional:true, dependent: :destroy

## product_category
|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|category_id|references|foreign_key: true|
### Association
- belongs_to :product, optional:true, dependent: :destroy
- belongs_to :category, optional:true, dependent: :destroy

## category
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
- has_many :product_category, dependent: :destroy

## seller
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|
|delivery_time|integer|foreign_key: true|
|delivery/method|string|foreign_key: true|
- has_one :delivery_fee, dependent: :destroy
- has_many :product, dependent: :destroy
- belongs_to :user, optional:true, dependent: :destroy
- belongs_to :product, optional:true, dependent: :destroy

## buyer
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|
- has_one :delivery_fee, dependent: :destroy
- has_one :product, dependent: :destroy
- belongs_to :user, optional:true, dependent: :destroy
- belongs_to :product, optional:true, dependent: :destroy

## delivery_fee
|Column|Type|Options|
|------|----|-------|
|seller_id|references|foreign_key: true|
|buyer_id|references|foreign_key: true|
- belongs_to :seller, optional:true, dependent: :destroy
- belongs_to :buyer, optional:true, dependent: :destroy