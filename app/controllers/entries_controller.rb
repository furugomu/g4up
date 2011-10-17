class EntriesController < ApplicationController
  #caches_page :index
  #cache_sweeper :entry_sweeper

  def index
    @entries = Entry.root.recent.page(params[:page]).per(2)
    @tags = Entry.tag_counts_on(:tags)
  end

  def new
    @entry = Entry.new()
  end

  def create
    @entry = Entry.new(params[:entry])
    unless @entry.valid?
      render :action=>:new and return
    end
    @entry.save
    redirect_to :root
  end

end
