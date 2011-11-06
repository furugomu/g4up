# -*- encoding: UTF-8 -*-
class Entry < ActiveRecord::Base
  belongs_to :parent, class_name: 'Entry', counter_cache: :replies_count
  has_many :replies, class_name: 'Entry', foreign_key: :parent_id
  has_many :complaints, dependent: :delete_all
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
    use_timestamp: false,
    url: '/system/:attachment/:id/:style/g4u:id.:extension',
    storage: lambda {|attachment|
      default = Rails.env.production? ? :s3 : :filesystem
      (attachment.instance.storage || default).to_sym
    },
    path: lambda {|attachment|
      if attachment.instance.storage == 's3'
        '/photo/:id/:style/g4u:id.:extension'
      else
        ':rails_root/public:url'
      end
    },
    s3_credentials: Rails.root.join('config', 's3.yaml').to_s,
    s3_host_name: 's3-ap-northeast-1.amazonaws.com',
    bucket: 'g4u',
  })
  acts_as_taggable
  paginates_per 24

  attr_accessor :other_tags
  attr_accessible :photo, :body, :tag_list, :other_tags

  scope :recent, order("#{quoted_table_name}.created_at desc")
  scope :root, where(parent_id: nil)

  validates :body, length: {maximum: 140}
  validates :photo, presence: {unless: :parent}
  validates_each :photo do |record, attr, photo|
    photo.queued_for_write[:original] or next
    dimensions = Paperclip::Geometry.from_file(photo.queued_for_write[:original])
    unless dimensions.width == 1280 && dimensions.height == 720
      record.errors.add(attr, 'のサイズは 1280x720 にしてください。')
    end
  end
  validates :photo_file_name, presence: {unless: :parent}
  validates_attachment_size :photo, :less_than => 600.kilobytes, message: 'は 600KB 以下にしてください。'
  validates :photo_fingerprint, uniqueness: true

  before_validation :add_tag_from_filename
  before_save :add_other_tags

  def censor!
    update_attribute(:censored, true)
  end

  def root?
    parent_id.blank?
  end

  def filename
    photo.blank? and return nil
    File.basename(photo.path)
  end

  def change_storage(new_storage)
    old_storage = self.storage
    old_path = photo.path
    file = photo.to_file
    update_attribute(:storage, new_storage)
    self.reload
    self.photo = file
    self.save
    if old_storage == 'filesystem'
      File.unlink(old_path)
    end
  end

  def idol_tag
    self.tag_list.detect{|x|Imas.idol_names.include?(x)}
  end

  private

  def photo_blank?
    photo_file_name.blank?
  end

  def body_blank?
    body.blank?
  end

  # ファイル名にアイドルの名前が含まれていたらタグに追加
  def add_tag_from_filename
    photo.original_filename.present? or return
    tag = Imas.idol_names.detect{|n| photo.original_filename.include?(n)}
    self.tag_list << tag if tag
  end

  def add_other_tags
    ts = other_tags.to_s.strip.split(/\s+/)
    tag_list.concat(ts) if ts.present?
  end

end
