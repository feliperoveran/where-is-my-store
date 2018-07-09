class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.text :name, null: false
      t.text :owner, null: false
      t.text :document, null: false
      t.multi_polygon :coverage_area, null: false
      t.st_point :address, null: false

      t.timestamps
    end

    add_index :stores, :coverage_area, using: :gist
    add_index :stores, :address, using: :gist
  end
end
