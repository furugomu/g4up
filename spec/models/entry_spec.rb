require 'spec_helper'

describe Entry do
  it '画像を添付' do
    e = Entry.new(:photo=>Rails.root.join('spec','files','imas9393.jpg'))
    e.should be_valid
    e.save
  end

  it 'hoge' do
    ' '.should be_blank
  end
end
