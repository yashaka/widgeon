require 'resources/core/page_helper'

module TestApp
  class Order
    include PageObject

    def open
      visit 'order.html'
    end

    def init
      w :details, OrderDetails, '#order_details'
      ww :items, Item, '[id^="item"]'
      e :add_item, '#add_item'
    end

    def add_item_with data = {}
      add_item.click
      items.last.tap { |item|
        item.fill_with data
      }
    end

    class OrderDetails
      include Widget

      def init
        e :first_name, '[name="first_name"]'
        e :last_name,  '[name="last_name"]'
        w :salutation, SelectList, '#salutation'
      end
    end

    class Item
      include Widget

      def init
        e :name, '.item_name'
        e :other_data, '.item_other_data'
        e :show_advanced_options_selector, '#show_advanced_options_selector'
        w :advanced_options_selector, AdvancedOptionsSelector, '#advanced_options_selector', :open => lambda {
          show_advanced_options_selector.click
        }
        e :show_advanced_options, '#show_advanced_options'
        w :advanced_options_section, AdvancedOptions, '#advanced_options', :open => lambda {
          show_advanced_options.click
        }
      end

      def add_advanced_options options_data
        options_data.each { |filter_data| advanced_options_selector.add_filter_with filter_data }
        advanced_options_selector.apply_filtered_options.click
        self
      end

      class AdvancedOptionsSelector
        include Widget

        def init
          e :add_options_filter, '#add_options_filter'
          e :apply_filtered_options, '#apply_filtered_options'
          ww :filters, OptionsFilter, '[id^="options_filter"]'
        end

        def add_filter_with data = {}
          add_options_filter.click
          filters.last.tap { |f| f.fill_with data }
        end

        class OptionsFilter
          include Widget

          def init
            w :type, SelectList, '#options_scope_type'
            w :scope, SelectList, '#options_scope'
          end

        end
      end

      class AdvancedOptions
        include Widget

        def init
          ajaxed_at '#options_list' do
            ww :options, AdvancedOption, 'li'
          end
        end

        class AdvancedOption
          include Widget

          def init
            #todo...
          end
        end
      end
    end

  end
end