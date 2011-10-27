# -*- encoding: UTF-8 -*-
class Entry < ActiveRecord::Base
  belongs_to :parent, class_name: 'Entry', counter_cache: :replies_count
  has_many :replies, class_name: 'Entry', foreign_key: :parent_id
  has_many :complaints, dependent: :delete_all
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
    url: '/system/:attachment/:id/:style/g4u:id.:extension',
    storage: Rails.env.production? ? :s3 : :filesystem,
    path: (Rails.env.production? ? '/photo/:id/:style/g4u:id.:extension'
                                 : ':rails_root/public:url'),
    s3_credentials: Rails.root.join('config', 's3.yaml').to_s,
    s3_host_name: 's3-ap-northeast-1.amazonaws.com',
    bucket: 'g4u',
  })
  acts_as_taggable

  attr_accessible :photo, :body, :tag_list

  scope :recent, order("#{quoted_table_name}.created_at desc")
  scope :root, where(parent_id: nil)

  validates :body, length: {maximum: 140}, presence: {if: :photo_blank?}
  validates :photo, presence: {if: :body_blank?}
  validates_each :photo do |record, attr, photo|
    photo.queued_for_write[:original] or next
    dimensions = Paperclip::Geometry.from_file(photo.queued_for_write[:original])
    unless dimensions.width == 1280 && dimensions.height == 720
      record.errors.add(attr, '1280x720 でないといけません')
    end
  end

  #def tag_list=(tags)
  #  set_tag_list_on(:tags, tags.strip.split(/\n+/).map(&:strip))
  #end

  def censor!
    update_attribute(:censored, true)
  end

  def root?
    parent_id.blank?
  end

  private

  def photo_blank?
    photo_file_name.blank?
  end

  def body_blank?
    body.blank?
  end

end
