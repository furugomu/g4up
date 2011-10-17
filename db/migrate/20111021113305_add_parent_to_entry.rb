class AddParentToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :parent_id, :integer
    add_column :entries, :replies_count, :integer, null: false, default: 0
    add_index :entries, :parent_id
  end
end
