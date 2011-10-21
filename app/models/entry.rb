class Entry < ActiveRecord::Base
  has_attached_file(:photo, {
    styles: {thumb: '320x180'},
  })
end
