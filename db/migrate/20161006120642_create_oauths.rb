class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.references :user, null: false, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.text   :info

      t.timestamps null: false
      t.datetime  :deleted_at
    end
  end
end
