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

require 'widgeon/page_object'

module Widgeon
  module Widget
    include PageObject

    def initialize owner, element_with_finders
      super()
      # TODO: think on: how about `widget.doto [:owner=, self], [:element_with_finders=, widget_element], :open` ?
      #   hm... there is an `if` in the end... so here it will not work... but in general... why not?
      self.owner = owner
      self.element_with_finders = element_with_finders
      # TODO: think on:
      #   currently #open is responsible for full load,
      #   i.e. it should define by itself whether page is itself loaded or not
      #   will it be better to move this login into separate method like `#loaded?`
      #   and so change next line to something like
      #     `widget.open unless widget.loaded or not widget.respond_to? :open`
      self.open if self.respond_to? :open
    end
  end
end