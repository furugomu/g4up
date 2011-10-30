class EntriesController < ApplicationController
  respond_to :html, :json, :js

  #caches_page :index
  #cache_sweeper :entry_sweeper

  def index
    @entries = Entry.root.recent.page(params[:page])
    # tag cloud
    #@tags = Entry.tag_counts_on(:tags)
  end

  def show
    @entry = Entry.find(params[:id])
    @replies = @entry.replies.recent.page(params[:page])
    @reply = @entry.replies.new
    respond_with @entry
  end

  def full
    @entry = Entry.find(params[:id])
    if request.referrer.blank?
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
    redirect_to :root
  end

  def edit
    @entry = Entry.root.find(params[:id])
  end

  def update
    @entry = Entry.root.find(params[:id])
    @entry.tag_list = params[:entry][:tag_list]
    @entry.save()
    redirect_to @entry
  end
end
