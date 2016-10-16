class IndexExp < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.index :expire_at
    end
  end
end
