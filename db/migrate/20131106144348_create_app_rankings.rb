class CreateAppRankings < ActiveRecord::Migration
  def change
    create_table :app_rankings do |t|
      t.references :app, index: true
      t.string :type
      t.integer :ranking

      t.timestamps
    end
  end
end
