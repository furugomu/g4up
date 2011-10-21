class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :body, :null=>false, :default=>''
      # paperclip
      t.string :photo_file_name, :null=>false, :default=>''
      t.string :photo_content_type, :null=>false, :default=>''
      t.integer :photo_file_size, :null=>false, :default=>0
      t.datetime :photo_updated_at
      t.string :photo_fingerprint

      t.timestamps
    end
    add_index :entries, :created_at
  end
end
