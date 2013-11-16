* Connect with travis-ci, code-climate, codeship, code-coverage(coveralls.io), 
  rubygems.org(gem version), gemnasium.com(dependencies), pullreview.com, waffle.io services.

* Improve README file. Add these service's badges to README file. Describe other methods in README file.
  e.g. [README example](https://github.com/slim-template/slim/blob/master/README.md)

* Add extension has_<item>? and include_<item>? aliases to Array Class.
  With `type` & `sensitive` parameter which means type of an object doesn't matter.
  `type` parameter accepts :symbol, :string, :boolean and :integer types.
  `sensitive` parameter by default is false.
  e.g.
  ```ruby
    products = [:note_book, :phone, :keyboard]

    [:male, :female].has_male?  => true
    products.has_phone?         => true
    products.include_phone?     => true
    products.has_phone?(true)   => false
  ```