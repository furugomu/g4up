class AddIndexEntriesPhotoFingerprint < ActiveRecord::Migration
  def up
    add_index :entries, :photo_fingerprint
  end

  def down
    remove_index :entries, :photo_fingerprint
  end
end
