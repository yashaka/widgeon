require 'spec_helper'

describe 'Acceptance End to End test' do
  it 'Fills order' do
    visit_page Order do |order|

      order.details.fill_with :first_name => 'Johanna', :last_name => 'Smith', :salutation => 'Mrs'

      order.add_item_with(:name => 'New Test Item', :other_data => 'Some other specific data').tap do |item|

        item.add_advanced_options [[{:option_type => 'type1'}, {:scope => 'optionscope2fortype1'}],
                                   [{:option_type => 'type2'}, {:scope => 'optionscope3fortype2'}]]

        item.advanced_options_section.options.tap do |opts|
          expect(opts.size).to eq 2
          expect(opts.map &:text).to eq ['optionscope2fortype1', 'optionscope3fortype2']
        end
      end
    end
  end
end