class CreateNames < ActiveRecord::Migration[5.2]
  def change
    create_table :names do |t|
      t.string :name
      t.timestamps

      add_column :items, :name, :string
    end
  end
end
