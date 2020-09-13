# README

<!-- active_hashで作成するデータ郡については以下判断で処理 -->
<!-- テーブルは作成しない／Associationにも記述しない／Colum,Type,Optionは記述する -->

## users テーブル

| Column                  | Type       | Options                    |
| ----------------------- | ---------- | -------------------------- |
| id                      | string     | null: false                |
| delivery_information_id | references | null: false                |
| credit_card_id          | references | null: false                |
| nickname                | string     | null: false                |
| email                   | string     | null: false , unique: true |
| password                | string     | null: false , unique: true |
| first_name              | string     | null: false                |
| family_name             | string     | null: false                |
| first_name_furigana     | string     | null: false                |
| family_name_furigana    | string     | null: false                |
| birth_date              | date       | null: false                |
| created_at              | timestanp  | null: false                |
| updated_at              | timestanp  |                            |

### Association

- has_many :items , dependent: :destroy
- has_many :credit_cards , dependent: :destroy
- has_many :delivery_information , dependent: :destroy
- has_many :items_purchases , dependent: :destroy

## delivery_information テーブル

| Column                        | Type       | Options                         |
| ----------------------------- | ---------- | ------------------------------- |
| id                            | string     | null: false                     |
| user_id                       | references | null: false , foreign_key: true |
| prefecture_id(acitve_hash)    | integer    | null: false                     |
| delivery_family_name          | string     | null: false                     |
| delivery_first_name           | string     | null: false                     |
| delivery_family_name_furigana | string     | null: false                     |
| delivery_first_name_furigana  | string     | null: false                     |
| postal_code                   | string     | null: false                     |
| city                          | string     | null: false                     |
| address                       | string     | null: false                     |
| building_room_number          | string     |                                 |
| phone_number                  | string     |                                 |
| created_at                    | timestanp  | null: false                     |
| updated_at                    | timestanp  |                                 |

### Association

- belongs_to :user

## credit_cards テーブル

| Column      | Type       | Options                         |
| ----------- | ---------- | ------------------------------- |
| id          | string     | null: false                     |
| user_id     | references | null: false , foreign_key: true |
| customer_id | string     | null: false                     |
| card_id     | string     | null: false                     |
| created_at  | timestanp  | null: false                     |
| updated_at  | timestanp  |                                 |

### Association

- belongs_to :user

## items テーブル

| Column                        | Type       | Options                         |
| ----------------------------- | ---------- | ------------------------------- |
| id                            | string     | null: false                     |
| seller_id                     | references | null: false , foreign_key: true |
| buyer_id                      | references | null: false , foreign_key: true |
| category_id                   | references | null: false , foreign_key: true |
| size_id(acitve_hash)          | integer    |                                 |
| prefecture_id(acitve_hash)    | integer    | null: false                     |
| condition_id(acitve_hash)     | integer    | null: false                     |
| shipping_fee_id(acitve_hash)  | integer    | null: false                     |
| delivery_days_id(acitve_hash) | integer    | null: false                     |
| name                          | string     | null: false                     |
| price                         | integer    | null: false                     |
| description                   | text       | null: false                     |
| brand_id                      | references | foreign_key: true               |
| created_at                    | timestanp  | null: false                     |
| updated_at                    | timestanp  |                                 |

### Association

- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- has_many :images , dependent: :destroy
- belongs_to :category

## images テーブル

| Column     | Type       | Options                         |
| ---------- | ---------- | ------------------------------- |
| id         | string     | null: false                     |
| item_id    | references | null: false , foreign_key: true |
| src        | string     | null: false                     |
| created_at | timestanp  | null: false                     |
| updated_at | timestanp  |                                 |

### Association

- belongs_to :item

## categories テーブル

| Column     | Type      | Options     |
| ---------- | --------- | ----------- |
| id         | string    | null: false |
| name       | string    | null: false |
| ancestry   | string    |             |
| created_at | timestanp | null: false |
| updated_at | timestanp |             |

### Association

- has_many :items
- has_ancestry

## favorites テーブル

| Column     | Type       | Options                         |
| ---------- | ---------- | ------------------------------- |
| id         | string     | null: false                     |
| user_id    | references | null: false , foreign_key: true |
| item_id    | references | null: false , foreign_key: true |
| created_at | timestanp  | null: false                     |
| updated_at | timestanp  |                                 |

### Association

- has_many :user
- has_many :item