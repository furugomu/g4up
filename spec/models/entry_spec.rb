# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe Entry do
  describe 'new' do
    subject { Entry.new }
    it { should_not be_valid }
    its(:storage) { should == 'filesystem' }
  end

  describe 'from factory' do
    subject { create(:entry) }
    it { should be_valid }
  end

  it 'タグは空白区切り' do
    e = Entry.new(tag_list: 'う ん    こ')
    e.tag_list.should == ['う', 'ん', 'こ']
  end

  describe 'with photo(伊織.jpg)' do
    subject {
      Entry.new(photo: Rails.root.join('spec','files','伊織.jpg').open()).tap(&:valid?)
    }
    it { should be_valid }
    its(:tag_list) { should be_include('伊織') }
  end

  describe 'setting other_tags' do
    before do
      @tags = 'う ど ん'
    end
    subject {
      create(:entry).tap{|e| e.other_tags = @tags; e.valid? }
    }
    its(:other_tags) { should == @tags }
    its(:tag_list) { should == @tags.split(/ /) }
  end

  describe 'search by date' do
    before do
      (9..12).each do |day|
        [[0,0,0], [23,59,59]].each do |h, m, s|
          t = Time.zone.local(2011, 11, day, h, m, s)
          build(:entry, created_at: t).save(validate: false)
        end
      end
    end
    it '>= 2011-11-11 00:00:00' do
      e = Entry.date_from('2011-11-11').order('created_at asc').first
      e.created_at.should == Time.zone.local(2011, 11, 11, 0, 0, 0)
    end
    it '<= 2011-11-11 23:59:59' do
      e = Entry.date_to('2011-11-11').order('created_at desc').first
      e.created_at.should == Time.zone.local(2011, 11, 11, 23, 59, 59)
    end
  end
end
