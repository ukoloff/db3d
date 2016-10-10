class AddAuthor < ActiveRecord::Migration
  def change
    change_table :tools do |t|
      t.string :author
    end
  end
end
