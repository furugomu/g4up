class FeedController < ApplicationController
  respond_to :xml
  def atom
    @entries = Entry.root.recent.includes(:tags).limit(40)
    render content_type: 'application/atom+xml'
  end
end
