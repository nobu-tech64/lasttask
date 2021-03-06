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
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_ruby|string|null: false|
|last_name_ruby|string|null: false|
|birthyear|integer|null: false|
|birthmonth|integer|null: false|
|birthday|integer|null: false|
### Association
- has_one :address, dependent: :destroy
- has_one :creditcard, dependent: :destroy
- has_one :seller, dependent: :destroy
- has_one :buyer, dependent: :destroy
- has_many :product, dependent: :destroy

## address
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|null: false|
|phone_number|integer|null: false|
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

## 4/20エラー（マイグレーションファイルが更新されていない）→原因不明

本番環境のマイグレーションファイルをdownした状態で自動デプロイすると、ローカル環境のマイグレーションファイルが本番環境に反映する。

ただし、本番環境・開発環境共に、外部キー（foreign_key :true）が設定されている状態だとdownできないので、その場合はデータベースを再作成（drop,create）する必要がある。


## 4/25エラー（foreign_keyを設定するとmigrateできなくなる）→解決

上記のdb:drop、db:create後、（つまり全てのマイグレーションファイルがdownの状態。ただしschema.rbファイルと齟齬があるためdb:statusでは確認できない）foreign_key :trueを設定し、db:migrateしたがそれでもMysql2::Error: Cannot add foreign key constraintとでる。

（解説）
マイグレーションファイルの読み込み順の問題だったようだ。
マイグレーションファイルの数字は日付を表しており、これによって読み込む順番が決定する。
例えば、20200412090000.create_images.rbは２０２０年４月１２日９時ちょうどに作られたマイグレーションファイルなのでこういうファイル名になっている。
この数字によって読み込む順番が決定し、
20200412090000.create_images.rb　と
20200414090000.create_brands.rb　なら
早く作られた方が読み込まれるので、１２日のimage→１４日のbrandsとなる。
今回のエラーはこれがわかっていなかったことに加えて、外部キーの参照元（id記入する方）と参照先の関係を成立させるためには、
『参照先のマイグレーションファイルを先に読み込む必要がある』
というルールに引っかかったためのエラーだった。
