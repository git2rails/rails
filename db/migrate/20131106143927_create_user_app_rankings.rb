class CreateUserAppRankings < ActiveRecord::Migration
  def change
    create_table :user_app_rankings do |t|
      t.references :app, index: true
      t.references :user, index: true
      t.string :ranking
      t.integer :points

      t.timestamps
    end
  end
end
