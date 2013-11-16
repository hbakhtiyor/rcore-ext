# Ruby Core Extensions

[![Gem Version](https://badge.fury.io/rb/rcore-ext.png)](http://badge.fury.io/rb/rcore-ext)
[![Coverage Status](https://coveralls.io/repos/hbakhtiyor/rcore-ext/badge.png)](https://coveralls.io/r/hbakhtiyor/rcore-ext)
[![Code Climate](https://codeclimate.com/github/hbakhtiyor/rcore-ext.png)](https://codeclimate.com/github/hbakhtiyor/rcore-ext)
[![Dependency Status](https://gemnasium.com/hbakhtiyor/rcore-ext.png)](https://gemnasium.com/hbakhtiyor/rcore-ext)
[![Build Status](https://travis-ci.org/hbakhtiyor/rcore-ext.png?branch=master)](https://travis-ci.org/hbakhtiyor/rcore-ext)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/hbakhtiyor/rcore-ext/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

The `rcore_ext` gem extends several core classes


## Installation

Add this line to your application's Gemfile:

    gem 'rcore-ext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rcore-ext

## Usage

Examples:

### Numeric methods

```ruby
"1".is_integer?             #=> true
"1.0".is_integer?           #=> false
"not_numeric".is_integer?   #=> false
```

```ruby
"1".is_numeric?             #=> true
"1.0".is_numeric?           #=> true
"not_numeric".is_numeric?   #=> false
```

```ruby
"1".is_float?             #=> false
"1.0".is_float?           #=> true
"not_numeric".is_float?   #=> false
```

```ruby
"1".to_numeric                #=> 1
"1".to_numeric.class          #=> Fixnum
"1.0".to_numeric              #=> 1.0
"1.0".to_numeric.class        #=> Float
("1" * 10).to_numeric         #=> 1111111111
("1" * 10).to_numeric.class   #=> Bignum
"not_numeric".to_numeric      #=> nil 
```

### Decode/encode methods

```ruby
"hello world!".decode_string(:hex)  #=> 68656c6c6f20776f726c6421
"hi".decode_string(:bin)            #=> 0110100001101001

"NBSWY3DPEB3W64TMMQQQ====".decode_string(:base32)   #=> hello world!
"aGVsbG8gd29ybGQh\n".decode_string(:base64)         #=> hello world!  

"aGVsbG8gd29ybGQh".decode_string(:base64, strict: true) #=> hello world!
```

```ruby
"68656c6c6f20776f726c6421".decode_string(:hex)  #=> hello world!
"0110100001101001".decode_string(:bin)          #=> hi

"hello world!".decode_string(:base32)   #=> NBSWY3DPEB3W64TMMQQQ====
"hello world!".decode_string(:base64)   #=> aGVsbG8gd29ybGQh\n  

"hello world!".decode_string(:base64, strict: true) #=> aGVsbG8gd29ybGQh  
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request