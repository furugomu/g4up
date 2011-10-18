# -*- encoding: utf-8 -*-
class Complaint < ActiveRecord::Base
  THREASHOLD = 5

  belongs_to :entry, counter_cache: true

  validates :entry, :ip_address, presence: true
  validates :entry_id, presence: true, uniqueness: {scope: :ip_address}
  validates :ip_address, format: /\d{1,3}(\.\d{1,3}){3}/

  after_create :censor_entry

  private

  # 検閲する
  def censor_entry
    # counter_cache は未反映なので +1 する
    if entry.complaints_count+1 >= THREASHOLD
      entry.censor!
    end
  end
end
