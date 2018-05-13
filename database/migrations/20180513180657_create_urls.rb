class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls, id: :serial, force: :cascade do |t|
      t.string :key, null: false
      t.string :original_url, null: false

      t.timestamps
    end

    add_index :urls, :key, unique: true
  end
end
