class AddComplaintsCountToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :complaints_count, :integer, null: false, default: 0
    add_column :entries, :censored, :boolean, null: false, default: false
  end
end
