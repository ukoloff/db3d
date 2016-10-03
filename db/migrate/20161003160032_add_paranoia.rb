class AddParanoia < ActiveRecord::Migration
  def change
    change_table :tools do |t|
      t.datetime :deleted_at
    end
  end
end
