class AddSize < ActiveRecord::Migration
  def change
    change_table :fotos do |t|
      t.integer :size
    end
  end
end
