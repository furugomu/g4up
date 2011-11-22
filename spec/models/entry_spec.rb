# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe Entry do
  it 'storage の初期値は filesystem' do
    e = Entry.new()
    e.storage.should == 'filesystem'
  end

  it 'タグは空白区切り' do
    e = Entry.new(tag_list: 'う ん    こ')
    e.tag_list.should == ['う', 'ん', 'こ']
  end

  it '画像を添付' do
    e = Entry.new(photo: Rails.root.join('spec','files','imas9393.jpg').open())
    e.should be_valid
    #e.save
  end
end
