class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :text, null: false, unique: true

      t.timestamps(null: false)
    end
  end
end
