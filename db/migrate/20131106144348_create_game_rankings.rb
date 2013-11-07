class CreateGameRankings < ActiveRecord::Migration
  def change
    create_table :game_rankings do |t|
      t.references :app, index: true
      t.string :type
      t.integer :ranking

      t.timestamps
    end
  end
end
