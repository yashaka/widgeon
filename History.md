# Version 1.1.0
Release date: unreleased

This is the last version of Widgeon that supports ruby 1.8.7. After next version is released, it will be still possible to 
use '1.8.7' version of Widgeon from the separate branch.

### Added
* basic acceptance spec testing dummy test app.
* `widgeon/helpers/wait.rb` helpers to implement waiting until element matches needed state in the cases where Capybara can't do this automatically

### Changed
* `PageObject#widget` to understand `:open` and `:opened?` lambdas passed to the last `options` param. So LoadableWidgets can be implemented without defining its own `#open` method and hold the knowledge about their owner (what is a bit of example of tight coupling). This will also fix the problem when original `#open` method will not work because widget is still not in DOM to be 'opened'

### Fixed
* `PageObject#within` to include case of 'waiting for the element become visible', not only 'appear in DOM'.