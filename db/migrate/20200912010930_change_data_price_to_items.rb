class ChangeDataPriceToItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :price, :integer, null: false
  end

  def down
    change_column :items, :price, :string, null: false
  end
end
