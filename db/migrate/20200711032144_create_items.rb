class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreignkey: true
      t.references :category, foreignkey: true
      t.string :name, null:false
      t.string :price, null:false
      t.text :description, null: false
      t.integer :size_id
      t.integer :condition_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_fee_id, null: false
      t.integer :delivery_days_id, null: false 
      t.references :brand
      t.timestamps
    end
  end
end
