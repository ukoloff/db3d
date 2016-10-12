class AddCreator < ActiveRecord::Migration
  def change
    change_table :tools do |t|
      t.references :creator
    end
    change_table :fotos do |t|
      t.references :creator
    end
  end
end
