class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.belongs_to :entry, null: false
      t.string :ip_address, null: false

      t.timestamps
    end
    add_index :complaints, :entry_id
    add_index :complaints, :ip_address
  end
end
