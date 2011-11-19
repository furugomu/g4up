# -*- encoding: UTF-8 -*-
class TagsController < ApplicationController
  def show
    @tag_name = params[:id]
    @title = '「%s」の画像一覧' % @tag_name
    @entries = Entry.root.tagged_with(params[:id]).
                 recent.page(params[:page])
  end
end
