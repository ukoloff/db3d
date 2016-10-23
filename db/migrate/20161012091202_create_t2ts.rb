class CreateT2ts < ActiveRecord::Migration
  def change
    create_table :t2ts do |t|
      t.references :tool, null: false, index: true
      t.references :tag, null: false
      t.references :creator

      t.timestamps null: false

      t.index %w(tag_id tool_id), unique: true
    end
  end
end
