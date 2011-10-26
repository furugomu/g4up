class TagsController < ApplicationController
  def show
    @tag_name = params[:id]
    @entries = Entry.root.tagged_with(params[:id]).
                 recent.page(params[:page]).per(20)
  end
end
