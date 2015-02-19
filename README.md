# Widgeon

Widgeon provides implementation of PageObject pattern for Capybara 2.0.3 to be compatible with Ruby 1.8.7.
Later it will support latest versions of Capybara and the compatibility with older Ruby will be left in the gem's alternative correspondent branch.

Widgeon is based on the tooth gem (https://github.com/kliuchnikau/tooth/) and extends its abilities in context of constructing PageObjects based on self-opened (optionally) widgets ('components' in tooth) and their collections. Self-opened widgets was inspired by Selenium's LoadableComponent pattern, but applied to complex html elements (or components/widgets) and implemented in the less tightly coupled way.  There is also a common implementation of PageFactory for widgeon PageObjects. In addition you can find a common implementation of "waiting" for AJAX helpers, which are not needed in real life if you use Capybara, but was needed at least in building Widgeon itself.

Widgeon was created recently and it's still pretty raw. Its DSL may be enhanced in future.

## Installation

Add this line to your application's Gemfile:

    gem 'widgeon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install widgeon

## Usage

### Basic example

```ruby
require 'widgeon'
include Widgeon
    
class MainPage
  include PageObject                           
      
  def open
    visit '/main'
  end
      
  def init                                     
    e :some_element, '#some_element_locator'   
    ee :some_list_elements, '#some_list_of_elements'
    ww :articles, Article, '[id^="article"]'   
    e :open_side_panel, '#open_side_panel'
    w :side_panel, SidePanel, '#side_panel', :open => lambda {   
      open_side_panel.click                    
    }
  end
  
  # Assuming side panel exists only on main page its class defined inside the MainPage class
  class  SidePanel                             
    include Widget 
        
    def init
      w :sign_in_form, SignInForm, '#sign_in_form'
      e :other_element, '#other_element'
    end
        
    # Assuming SignInForm exists only inside side panel...
    class SignInForm                           
      include Widget
              
      def init
        e :mail, '#mail'
        e :password, '#password'
        e :signin, '#sign_in'
      end
              
      def do_signin mail_and_password = {}
        fill_with mail_and_password
        signin.click
      end
    end
  end
end
    
# Assuming articles may exist on several pages, the class is defined globally
class Article                                
  include Widget                            
      
  def init
    e :heading, 'heading'
    e :text, 'article'
    e :mark_as_read, '#mark_as_read'
  end
end
    
# -- -- -- 
    
require 'widgeon/page_factory'
include Widgeon::PageFactory
    
visit_page MainPage do |main|
  main.side_panel.sign_in_form.do_signin :mail => 'mail@example.com', :password => 'supersecret'
end
```

#### Example Explained

Make your class a 'widgeon' Pageobject:

```ruby
class MainPage
  include PageObject  
```

Define elements inside the `init` method:

```ruby
  def init                                     
    element :some_element, '#some_element_locator'   
    #...
  end
```

Define element with `'#some_element_locator'` and accessible from the page object by `some_element` name:

```ruby
    element :some_element, '#some_element_locator' 
```

Define a collection of elements:

```ruby
    elements :some_list_elements, '#some_list_of_elements'
```

Define a widget object (complex element/component containing other elements):
```ruby
      widget :sign_in_form, SignInForm, '#sign_in_form'
```
The additional second parameter (`SignInForm`) should be specified in order to tell the class where the widget is defined.

Define a collection of widgets:
```ruby
    widgets :articles, Article, '[id^="article"]' 
```

Define a widget that should be opened automatically if it's not visible:
```ruby
    widget :side_panel, SidePanel, '#side_panel', :open => lambda {   
      open_side_panel.click                    
    }
```

Use Aliases if needed:
```ruby
    e :some_element, '#some_element_locator'           # i.e. element
    ee :some_list_elements, '#some_list_of_elements'   # i.e. elements
    ww :articles, Article, '[id^="article"]'           # i.e. widgets
    e :open_side_panel, '#open_side_panel'
    w :side_panel, SidePanel, '#side_panel', :open => lambda { #i.e. widget
      open_side_panel.click                    
    }
```

Use factories to create and use page objects:
```ruby
visit_page MainPage do |main|
  main.side_panel.sign_in_form.do_signin :mail => 'mail@example.com', :password => 'supersecret'
end
```

### AJAX context handling with PageObject#within or PageObject#ajaxed_at block

Assuming some scope/list of elements will appear on the page only after some 'ajax loading', you can make the Widgeon wait for these elements by putting them into the `within` block:

```ruby

    def init
    
      ajaxed_at '#section_that_will_appear_after_some_loading_finished' do
        :ee :items, 'li#some_item'
      end
    
    end
```

`ajaxed_at` is just an alias to the `PageObject#within` in order to emphasize the goal of putting elements into the scope.

### More examples

See **/spec** files for more examples of usage.

## TODO list

* move to ruby 2.0 (update docs and comments correspondingly)
* refactor javascript code for the test dummy app to be more DRY
* add spec steps for testing a list of items of different type
* add examples for locators as lambdas
* consider removing 'loading widgets via Widget#open' in one of next major versions by removing the "owner" field 
* resolve all 'todos'
* refactor all comments to be of rdoc style, etc.
* consider enhancing DSL for element definition with an ability to define blocks with additional action, like:

```ruby


    e :login, '#login-btn' { |it| it.click}
    #or
    e :login, '#login-btn', :action => :click
    
    # - in order to write just:
  
    page.login
    
    # - instead of 
    
    page.login.click
    
    #or even like this:
    w :sign_in, SignInForm, '#sign-in', :do => { |it, mail_and_password| it.fill_with mail_and_password; it.submit }
    
    # - in order to:
    
    page.sign_in :mail => '...', :password => '...'
    
    # - instead of:
    
    page.sign_in.do_sign_in :mail => '...', :password => '...'
```    

* consider enhancing DSL to be able to define page elements and widgets outside of the `PageObject#init` method.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/widgeon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
