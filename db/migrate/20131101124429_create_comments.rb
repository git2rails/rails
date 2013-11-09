class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :post
      t.text :comment
      t.boolean :visible
      t.boolean :enabled
      t.integer :warning
      t.references :user
      t.timestamps
    end

    add_index :comments, :post_id
    add_index :comments, :user_id
  end

  def self.down
    drop_table :comments
  end
end
