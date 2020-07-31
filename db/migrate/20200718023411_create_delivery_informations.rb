class CreateDeliveryInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_informations do |t|
      t.references :user, optional: true
      t.integer :prefecture_id, null: false
      t.string :delivery_family_name, null: false
      t.string :delivery_first_name, null: false
      t.string :delivery_family_name_furigana, null: false
      t.string :delivery_first_name_furigana, null: false
      t.integer :postal_code, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building_room_number
      t.string :phone_number
      t.timestamps
    end
  end
end
