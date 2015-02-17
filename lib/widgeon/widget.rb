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
      # todo: think on: how about `widget.doto [:owner=, self], [:element_with_finders=, widget_element], :open` ?
      #   hm... there is an `if` in the end... so here it will not work... but in general... why not?
      self.owner = owner # this owner field was remembered here in order to be able to implement `#open` method in widget
                         # though, this was refactored because of 'bad tight coupling'
                         # and now todo: this may be considered for removal
                         # Hence, the Widget class itself will be just an "alias" for PageObject, with out any additional
                         # abilities... Though such abilities may appear in the future:)
      self.element_with_finders = element_with_finders

      self.open if self.respond_to? :open

      # loadable_lambda.call if loadable_lambda
    end
  end
end