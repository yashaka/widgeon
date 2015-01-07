module Widgeon
  module PageFactory
    def on page_class, opts = {}, &block
      opts = {:visit => false, :else => nil}.merge opts
      page_class = class_from_string(page_class) if page_class.is_a? String
      @page = page_class.new
      if opts[:visit] and @page.respond_to? :open
        if opts[:else]
          @page.open opts[:else]
        else
          @page.open
        end
      end
      block.call @page if block
      @page
    end

    def visit page_class, opts = {}, &block
      opts = {:visit => true}.merge opts
      on(page_class, opts, &block)
    end
  end
end