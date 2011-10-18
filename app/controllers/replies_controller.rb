class RepliesController < ApplicationController
  before_filter :find_entry
  def new
    @reply = @entry.replies.build(params[:entry])
  end

  def create
    @reply = @entry.replies.new(params[:entry].slice(:body, :photo))
    unless @reply.save()
      render action: :new and return
    end
    redirect_to @entry
  end

  private

  def find_entry
    @entry = Entry.find(params[:entry_id])
  end

end
