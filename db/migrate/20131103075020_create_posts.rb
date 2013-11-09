class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :app, index: true
      t.string :type
      t.text :content
      t.boolean :visible, :default => true, :null => false
      t.boolean :enabled, :default => true, :null => false
      t.integer :warning, :default => 0, :null => false
      t.references :user, index: true

      t.timestamps
    end
  end
end
