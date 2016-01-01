class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.integer :rank
      t.belongs_to :restaurant
      t.timestamps
    end
    add_index :comments, :restaurant_id
  end
end
