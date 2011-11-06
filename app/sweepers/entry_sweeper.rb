class EntrySweeper < ActionController::Caching::Sweeper
  observe Entry # This sweeper is going to keep an eye on the Entry model
 
  # If our sweeper detects that a Entry was created call this
  def after_create(entry)
    expire_cache_for(entry)
  end
 
  # If our sweeper detects that a Entry was updated call this
  def after_update(entry)
    expire_cache_for(entry)
  end
 
  # If our sweeper detects that a Entry was deleted call this
  def after_destroy(entry)
    expire_cache_for(entry)
  end
 
  private
  def expire_cache_for(entry)
    # Expire the index page now that we added a new entry
    expire_page('/index')
  end
end
