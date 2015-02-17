# Widgeon

Widgeon provides implementation of PageObject pattern for Capybara 2.0.3 to be compatible with Ruby 1.8.7.
Later it will also support latest versions of Capybara but the compatibility with older Ruby will be remained.

Widgeon is based on the tooth gem (https://github.com/kliuchnikau/tooth/)
and extends its abilities in context of constructing PageObjects based on self-loaded (optionally) widgets ('components' in tooth)
and their collections. There is also a common implementation of PageFactory for widgeon PageObjects.

## Installation

Add this line to your application's Gemfile:

    gem 'widgeon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install widgeon

## Usage

TODO: Write usage instructions here

## TODO list

* extend for latest versions of ruby and Capybara but leave compatibility with older versions.
* add USAGE & Docs
* refactor javascript code for the test dummy app
* add spec steps for testing a list of items of different type
* enhance DSL (create 'locators in hash-map' DSL; compare to non-DSL, raw OOP solution)
* add examples for locators as lambdas
* consider removing 'loading widgets via Widget#open' in one of next major versions
* resolve all 'todos'
* refactor comments to be of rdoc style
* add 'changes' file

## Contributing

1. Fork it ( https://github.com/[my-github-username]/widgeon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
