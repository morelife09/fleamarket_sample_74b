# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
<!-- active_hashで作成するデータ郡については以下判断で処理 -->
<!-- テーブルは作成しない／Associationにも記述しない／Colum,Type,Optionは記述する -->

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|delivery_information_id        |references|null: false , foreign_key: true|
|credit_card_id                 |references|null: false , foreign_key: true|
|nickname                       |string|null: false|
|email                          |string|null: false , unique: true|
|password                       |string|null: false , unique: true|
|first_name                     |string|null: false|
|family_name                    |string|null: false|
|first_name_furigana            |string|null: false|
|family_name_furigana           |string|null: false|
|birth_date                     |date|null: false|
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- has_many :items
- has_many :delivery_information
- has_many :credit_cards


## delivery_informationテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |references|null: false , foreign_key: true|
|prefecture_id                  |references|null: false , foreign_key: true|
|delivery_family_name           |string|null: false|
|delivery_first_name            |string|null: false|
|delivery_family_name_furigana  |string|null: false|
|delivery_first_name_furigana   |string|null: false|
|postal_code                    |string|null: false|
|city                           |string|null: false|
|address                        |string|null: false|
|building_room_number           |string||
|phone_number                   |string||
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :user


## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |references|null: false , foreign_key: true|
|customer_id                    |string|null: false|
|card_id                        |string|null: false|
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :user


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |references|null: false , foreign_key: true|
|credit_card_id                 |references|foreign_key: true|
|image_id                       |references|null: false , foreign_key: true|
|categories_id                  |references|null: false , foreign_key: true|
|size_id                        |references|foreign_key: true|
|prefecture_id                  |references|null: false , foreign_key: true|
|condition_id                   |references|null: false , foreign_key: true|
|shipping_fee_id                |references|null: false , foreign_key: true|
|delivery_days_id               |references|null: false , foreign_key: true|
|item_name                      |string|null: false|
|price                          |string|null: false|
|description                    |text|null: false|
|brand_id                       |references|foreign_key: true|
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :user
- belongs_to :credit_card
- has_many :images
- has_many :categories
- has_many :brands


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|item_id                        |references|null: false , foreign_key: true|
|image               　         |string|null: false|
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|category_name                  |string|null: false|
|ancestry_path                  |string||
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :item

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|brand_name                     |string|null: false|
|created_at                     |timestanp|null: false|
|updated_at                     |timestanp||
### Association
- belongs_to :item


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

