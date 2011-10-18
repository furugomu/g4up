class Entry < ActiveRecord::Base
  belongs_to :parent, class_name: 'Entry', counter_cache: :replies_count
  has_many :replies, class_name: 'Entry', foreign_key: :parent_id
  has_many :complaints, dependent: :delete_all
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
  })
  acts_as_taggable

  attr_accessible :photo, :body, :tag_list

  scope :recent, order("#{quoted_table_name}.created_at desc")
  scope :root, where(parent_id: nil)

  def tag_list=(tags)
    set_tag_list_on(:tags, tags.strip.split(/\n+/).map(&:strip))
  end

  def censor!
    update_attribute(:censored, true)
  end
end
