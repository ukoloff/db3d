class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.references  :tool
      t.string      :name
      t.string      :mime
      t.binary      :blob

      t.timestamps null: false
    end
  end
end
