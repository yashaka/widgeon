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