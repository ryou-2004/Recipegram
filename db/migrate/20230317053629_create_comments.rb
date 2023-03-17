class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id, foreign_key: true
      t.integer :recipe_id, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
