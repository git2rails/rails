class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :app, index: true
      t.string :content
      t.references :user, index: true

      t.timestamps
    end
  end
end
