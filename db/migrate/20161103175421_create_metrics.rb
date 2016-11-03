class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :page_id, null: false
      t.integer :word_id, null: false
      t.integer :first_position, null: false
      t.integer :frequency, null: false

      t.timestamps(null: false)
    end
  end
end
