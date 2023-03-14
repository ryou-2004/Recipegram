class CreateHashtagCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtag_counts do |t|
      t.date :date
      t.references :hashtag, null:false, foreign_key:true
      t.integer :count

      t.timestamps
    end
  end
end
