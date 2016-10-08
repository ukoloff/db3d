class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :disabled

      t.timestamps null: false
      t.datetime  :deleted_at
    end
  end
end
