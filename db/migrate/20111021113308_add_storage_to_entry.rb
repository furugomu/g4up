# -*- encoding: UTF-8 -*-
class AddStorageToEntry < ActiveRecord::Migration
  def change
    # 既存のは s3 に
    add_column :entries, :storage, :string, null: false, default: 's3'
    # これ以降は filesystem をデフォルト
    change_column_default :entries, :storage, 'filesystem'
  end
end
