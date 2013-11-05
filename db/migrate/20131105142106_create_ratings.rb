class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :app, index: true
      t.float :starts
      t.text :comment
      t.references :user, index: true

      t.timestamps
    end
  end
end
