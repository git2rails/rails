class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :opponent_id
      t.string :text
      t.boolean :sent
      t.boolean :enabled

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :opponent_id
  end
end