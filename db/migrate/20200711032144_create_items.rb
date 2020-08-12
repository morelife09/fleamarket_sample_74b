class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :buyer_id, foreign_key: true
      t.integer :seller_id , foreignkey: true
      t.references :category, foreignkey: true
      t.string :name, null: false
      t.string :price, null: false
      t.text :description, null: false
      t.integer :size_id
      t.integer :condition_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_fee_id, null: false
      t.integer :delivery_days_id, null: false 
      t.integer :brand_id
      t.timestamps
    end
  end
end