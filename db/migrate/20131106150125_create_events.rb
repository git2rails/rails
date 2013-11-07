class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :app, index: true
      t.string :content
      t.datetime :start_at
      t.datetime :end_at
      t.integer :priority

      t.timestamps
    end
  end
end
