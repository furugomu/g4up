class EntriesController < ApplicationController
  def index
    @entries = Entry.all()
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
