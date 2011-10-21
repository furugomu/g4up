class Entry < ActiveRecord::Base
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
  })
  acts_as_taggable

  attr_accessible :photo, :body, :tag_list
end
