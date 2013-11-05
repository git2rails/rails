class CreateAppRuntimeHistories < ActiveRecord::Migration
  def change
    create_table :app_runtime_histories do |t|
      t.references :app, index: true
      t.string :type
      t.integer :runtime
      t.references :user, index: true

      t.timestamps
    end
  end
end
