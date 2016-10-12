class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.text  :name, null: false, index: true
      t.references :creator
      t.datetime  :expire_at

      t.timestamps null: false
      t.datetime  :deleted_at
    end
  end
end
