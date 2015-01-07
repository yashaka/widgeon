require 'lib/deps/tooth/page_object'

module Widgeon
  module PageObject
    include Tooth::PageObject

    attr_accessor :owner

    # PageObject#ajaxed_at method is generated here for self-documenting reasons
    # in order to indicate in the PageObject's code the reason why this 'within' block is created:
    #   Such reason is to provide scope for the elements collection
    #   under parent 'within' element which is dynamically loaded by Ajax though not needed to be
    #   represented as separate PageObject's element.
    #
    # This is specifically needed for the 'elements collection' case (represented by #ee and #ww methods).
    # The problem fixed by such '#within or #ajaxed_at usage' workaround is:
    #   SINCE #ee and #ww methods search for collections of elements via finding
    #         Capybara::Node::Finders#all method returning an array of found results
    #   GIVEN expecting list of elements under dynamically loaded elements' parent html element
    #   WHEN  finding #all such elements with Capybara
    #   THEN  you will just receive an empty array
    # THUS
    #   WHEN  putting such #ee/#ww elements into #within/#ajaxed_at scope of their parent dynamically loaded
    #         element
    #   THEN  before #all, the #find will be called for parent element AND #find has ajax-friendly implicit waits
    #   AND   finally all #ee/#ww elements will be found
    #
    # TODO: think on: substituting this 'workaround' with 'ajax-friendly' #all method returning ElementsCollection, not
    #       simple array, with ability (maybe some helper 'wait' methods) to wait for its elements to appear...
    alias_method :ajaxed_at, :within

    def initialize *args
      @owner = self
      init
      puts ">>> PageObject initialized: #{self.class}" # TODO: remove once debugged
    end

    alias_method :e, :element
    alias_method :ee, :elements

    def widget name, widget_class, locator, options={}
      page_element[name] = lambda { |*args|
        widget_element = find(locator_string(locator, args), options)
        widget_class.new self, widget_element
      }
    end

    def widgets name, widget_class, locator, options={}
      page_element[name] = lambda { |*args|
        all(locator_string(locator, args), options).map do |widget_element|
          widget_class.new self, widget_element
        end
      }
    end

    alias_method :w, :widget
    alias_method :ww, :widgets

    def fill_with opts={}
      opts.each do |field, value|
        (self.send field).set value unless value.nil? # TODO: refactor to `if value`
      end
    end

  end
end