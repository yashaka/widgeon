#   Widgeon
#   Copyright 2015 Iakiv Kramarenko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and#
#   limitations under the License.
#
#   This product includes software developed by Iakiv Kramarenko (yashaka@gmail.com)
#
#   This product bundles and modifies tooth 0.3.0 page_object.rb
#   developed by Aliaksei Kliuchnikau (aliaksei.kliuchnikau@gmail.com)
#   For details, see lib/deps/tooth/page_object.rb.

module Widgeon
  module PageFactory
    def on_page page_class, opts = {}, &block
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

    def visit_page page_class, opts = {}, &block
      opts = {:visit => true}.merge opts
      on_page page_class, opts, &block
    end
  end
end