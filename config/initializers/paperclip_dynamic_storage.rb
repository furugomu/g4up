require 'paperclip/attachment'
module Paperclip
  class Options
    def initialize_with_dynamic_storage(attachment, hash)
      initialize_without_dynamic_storage(attachment, hash)
      @storage = @storage.call(@attachment) if @storage.is_a?(Proc)
    end
    alias_method_chain :initialize, :dynamic_storage
  end
end
