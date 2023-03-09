class CreateHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags do |t|
      t.string :name
      t.integer :recipe_id, foreign_key: true

      t.timestamps
    end
  end
end
