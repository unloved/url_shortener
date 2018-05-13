class CreateUrlVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :url_visits, id: :serial, force: :cascade do |t|
      t.bigint :url_id, null:false, index: true
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
