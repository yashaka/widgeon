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

require 'widgeon/widget.rb'

module Widgeon
  module Widgets
    class SelectList
      include Widget

      def init
        ee :options, 'option'
      end

      # TODO: why does the `alias_method :set, :select` code not work?
      def set option_value
        self.select option_value
      end

    end
  end
end