class EntriesController < ApplicationController
  respond_to :html, :json, :js
  include ApplicationHelper

  caches_page :index, :if=>lambda{|c| c.params[:page].nil? }
  cache_sweeper :entry_sweeper

  def index
    @entries = Entry.root.recent.includes(:tags).page(params[:page])
    # tag cloud
    @tags = Entry.tag_counts_on(:tags).order('count desc').limit(13)
  end

  def show
    @entry = Entry.find(params[:id])
    @replies = @entry.replies.recent.page(params[:page])
    @reply = @entry.replies.new
    respond_with @entry
  end

  def full
    @entry = Entry.find(params[:id])
    # 2ch ビューア等のインライン表示のため、
    # g4uxxx.jpg に直接来たら画像だけ表示。
    if params[:filename].present? && request.referrer.blank?
      redirect_to @entry.photo.url(:original) and return
    end
    render :layout=>'fullscreen'
  end

  def new
    @entry = Entry.new()
  end

  def create
    @entry = Entry.new(params[:entry])
    unless @entry.save()
      render action: :new and return
    end
    redirect_to entry_full_url(@entry)
  end

  def edit
    @entry = Entry.root.find(params[:id])
  end

  def update
    @entry = Entry.root.find(params[:id])
    @entry.attributes = params[:entry].slice(:tag_list, :other_tags)
    @entry.save()
    redirect_to entry_full_url(@entry)
  end

  private

  def redirect_to(url)
    return super unless ps3?
    # PS3 でふつうにリダイレクトすると bad content body と言われる
    # meta refresh だとリファラーが付かず、画像だけ表示になってしまうのでトップへ
    @url = root_url
    render inline: <<-XXX.strip_heredoc
      <%= tag(:meta,
              'http-equiv'=>'refresh',
              content: '0;%s' % @url) %>
    XXX
  end
end
