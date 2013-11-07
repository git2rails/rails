class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :app, index: true
      t.string :type
      t.text :content
      t.boolean :enabled
      t.boolean :blocked
      t.integer :warning
      t.references :user, index: true

      t.timestamps
    end
  end
end
