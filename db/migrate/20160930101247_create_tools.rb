class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.text   :note
      t.datetime :date
      
      t.timestamps null: false
    end
  end
end
