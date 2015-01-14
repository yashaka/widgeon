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

require 'deps/tooth/page_object'

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
      init if respond_to? :init
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

    # @param opts examples:
    #   - order does not matter:
    #     {:field1 => value1, :field2 => value2, :field3 => value3}
    #   - order does matter:
    #     [{:field1_should_be_set_first => value1}, {:field2 => value2, :field3 => value3}]
    def fill_with opts
      opts.is_a?(Hash) ? fill_with_hash(opts) : fill_with_array_of_hashes(opts)
    end

    def fill_with_hash opts={}
      opts.each do |field, value|
        (self.send field).set value unless value.nil? # TODO: refactor to `if value`
      end
    end

    def fill_with_array_of_hashes opts=[]
      opts.each { |hash| fill_with_hash hash }
    end

  end
end