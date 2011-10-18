class EntriesController < ApplicationController
  respond_to :html, :json, :js

  #caches_page :index
  #cache_sweeper :entry_sweeper

  def index
    @entries = Entry.root.recent.page(params[:page]).per(20)
    @tags = Entry.tag_counts_on(:tags)
  end

  def show
    @entry = Entry.find(params[:id])
    respond_with @entry
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

end
