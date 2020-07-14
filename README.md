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
|delivery_information_id        |string|null: false , foreign_key: true|
|credit_card_id                 |string|null: false , foreign_key: true|
|nickname                       |string|null: false , foreign_key: true|
|email                          |text|null: false , unique: true|
|password                       |text|null: false , unique: true|
|first_name                     |text|null: false|
|family_name                    |text|null: false|
|first_name_furigana            |text|null: false|
|family_name_furigana           |text|null: false|
|year_id                        |string|null: false , foreign_key: true|
|month_id                       |string|null: false , foreign_key: true|
|date_id                        |string|null: false , foreign_key: true|
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- has_many :items
- has_many :delivery_information
- has_many :credit_cards


## delivery_informationテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |string|null: false , foreign_key: true|
|prefecture_id                  |string|null: false , foreign_key: true|
|delivery_family_name           |text|null: false|
|delivery_first_name            |text|null: false|
|delivery_family_name_furigana  |text|null: false|
|delivery_first_name_furigana   |text|null: false|
|postal_code                    |string|null: false|
|city                           |text|null: false|
|address                        |text|null: false|
|building_room_number           |text||
|phone_number                   |text||
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- belongs_to :user


## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |string|null: false , foreign_key: true|
|credit_card_holder             |text|null: false|
|card_number                    |string|null: false|
|year_id                        |string|null: false , foreign_key: true|
|month_id                       |string|null: false , foreign_key: true|
|security_code                  |string|null: false|
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- belongs_to :user
- has_many :credit_cards


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|user_id                        |string|null: false , foreign_key: true|
|credit_card_id                 |string|foreign_key: true|
|image_id                       |string|null: false , foreign_key: true|
|categories_id                  |string|null: false , foreign_key: true|
|size_id                        |string|foreign_key: true|
|prefecture_id                  |string|null: false , foreign_key: true|
|condition_id                   |string|null: false , foreign_key: true|
|shipping_fee_id                |string|null: false , foreign_key: true|
|delivery_days_id               |string|null: false , foreign_key: true|
|item_name                           |text|null: false|
|price                          |string|null: false|
|description                    |text|null: false|
|brand_id                       |string|foreign_key: true|
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
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
|item_id                        |string|null: false , foreign_key: true|
|image_1                        |string|null: false|
|image_2                        |string||
|image_3                        |string||
|image_4                        |string||
|image_5                        |string||
|image_6                        |string||
|image_7                        |string||
|image_8                        |string||
|image_9                        |string||
|image_10                       |string||
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- belongs_to :item


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|category_name                  |text|null: false|
|ancestry_path                  |string||
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- belongs_to :item

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|id                             |string|null: false|
|brand_name                     |text|null: false|
|created_at                     |timestanp|null: false|
|update_at                      |timestanp||
### Association
- belongs_to :item


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

