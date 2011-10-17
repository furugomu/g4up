class EntriesController < ApplicationController
  def index
    @entries = Entry.recent.page(params[:page]).per(20)
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
    redirect_to :entries
  end

end
