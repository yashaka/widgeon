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