class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.string :price
      t.timestamps

      add_column :items, :price, :string
    end
  end
end
