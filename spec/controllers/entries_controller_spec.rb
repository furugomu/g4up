# -*- encoding: UTF-8 -*-
require 'spec_helper'

describe EntriesController do
  describe 'create' do
    let(:entry_param) { {photo: fixture_file_upload('/imas9393.jpg', 'image/jpg')} }

    it '増える' do
      expect {
        post 'create', entry: entry_param
      }.to change{Entry.count}.by(1)
    end
    it 'root にリダイレクト' do
      post 'create', entry: entry_param
      response.should redirect_to(:root)
    end
    it '@entry がある' do
      post 'create', entry: entry_param
      assigns(:entry).should_not be_nil
    end
    it '@entry が valid' do
      post 'create', entry: entry_param
      assigns(:entry).should be_valid
    end
  end

  describe 'index' do
    describe '@entries' do
      before do
        @entry = create(:entry)
        get 'index'
      end
      subject { assigns(:entries) }
      it { should_not be_nil }
      it { should respond_to(:page) }
      it { should include(@entry) }
    end
  end
end
