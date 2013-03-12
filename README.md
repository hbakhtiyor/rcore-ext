# Ruby Core Extensions

The `rcore_ext` gem extends several core classes

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


## Feel free for pull requests!