class OathIdx < ActiveRecord::Migration
  def change
    change_table :oauths do |t|
      t.index %w(provider uid)
    end
  end
end
