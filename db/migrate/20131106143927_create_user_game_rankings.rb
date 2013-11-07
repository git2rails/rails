class CreateUserGameRankings < ActiveRecord::Migration
  def change
    create_table :user_game_rankings do |t|
      t.references :app, index: true
      t.references :user, index: true
      t.string :ranking
      t.integer :points

      t.timestamps
    end
  end
end
