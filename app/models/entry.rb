# -*- encoding: UTF-8 -*-
class Entry < ActiveRecord::Base
  belongs_to :parent, class_name: 'Entry', counter_cache: :replies_count
  has_many :replies, class_name: 'Entry', foreign_key: :parent_id
  has_many :complaints, dependent: :delete_all
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
    use_timestamp: false,
    url: '/system/:attachment/:id/:style/g4u:id.:extension',
    storage: :filesystem,
    path: ':rails_root/public:url',
  })
  acts_as_taggable
  paginates_per 48

  attr_writer :other_tags
  attr_accessible :photo, :body, :tag_list, :other_tags

  scope :recent, order("#{quoted_table_name}.created_at desc")
  scope :root, where(parent_id: nil)
  scope :date_from, lambda{|time|
    time = Time.zone.parse(time) if time.is_a?(String)
    where(["#{quoted_table_name}.created_at >= ?", time])
  }
  scope :date_to, lambda{|time|
    time = Time.zone.parse(time) if time.is_a?(String)
    where(["#{quoted_table_name}.created_at <= ?", time.end_of_day])
  }

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
  before_validation :add_other_tags

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
    old_pathes = photo.styles.keys.map{|x|photo.path(x)} + [photo.path]
    file = photo.to_file
    update_attribute(:storage, new_storage)
    new_record = self.class.find(self.id)
    new_record.photo = file
    new_record.save
    if old_storage == 'filesystem'
      old_pathes.each do |path|
        File.unlink(path)
      end
    end
  end

  def idol
    Idol.all.detect{|x|self.tag_list.include?(x.name)}
  end

  class << self
    # 古いのを s3 に移す
    def archive(new_storage='s3', offset=1000)
      entries = where("photo_filename <> ''").
                where(storage: 'filesystem').
                order('id desc').offset(offset)
      entries.each do |entry|
        logger.debug('change_storage: %d, %s' % [entry.id, entry.photo.path])
        entry.change_storage(new_storage)
      end
    end
  end

  def other_tags
    @other_tags ||
      tag_list.reject{|x| Idol.names.include?(x)}.join(' ')
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
    names = Idol.names.sort_by(&:length).reverse
    tag = names.detect{|n| photo.original_filename.include?(n)}
    self.tag_list << tag if tag
  end

  def add_other_tags
    ts = other_tags.to_s.strip.split(/\s+/)
    tag_list.concat(ts) if ts.present?
  end

end
