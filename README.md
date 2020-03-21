# Ov

Create multimethods in Ruby

## Installation

Add this line to Gemfile:

    gem 'ov'

Execute:

    $ bundle

Or install it yourself as:

    $ gem install ov


## A few examples:

```ruby
require 'ov'

# ====== Define methods

class Foo
  include Ov

  let :foo, String do |str|
    # some code 
  end
end

foo = Foo.new
foo.foo("foo") # => ok
foo.foo(123) # => Method `foo` in `#<Foo:0x007fe423c19dc8>` class with types `Fixnum` not implemented. (Ov::NotImplementError)   
  
# ====== Custom Equality for Ruby Types


class String
  include Ov
  let :is_equal, String do |str|
    self == str 
  end 

  let :is_equal, Any do |other|
    raise TypeError.new("Only for string") 
  end
end

str = "foo"

p str == 123            # false, but this different types
p str.is_equal("bar")   # false
p str.is_equal("foo")   # true
p str.is_equal(123)     # TypeError


# ====== Use Ov::Ext for matching

require 'kleisli'

include Ov::Ext

match(Try{1/0}) {
  try(Kleisli::Try::Success) { puts "ok" }
  try(Kleisli::Try::Failure) { puts "error" }  
}

result = match(Net::HTTP.get_response(URI("http://google.com"))) do
  try(Net::HTTPOK) {|r| r.header }
  try(Net::HTTPMovedPermanently) {|r| r.header }
  otherwise { "error" }
end

puts result

```




## Usage

Firstly include `Ov` in your class

```ruby 
class MyClass 
  include Ov 
end
```

After: define method with types:

```ruby
class MyClass
  include Ov
  
  #with Fixnum type 
  let :cool_method, Fixnum do |num|
    num * 100
  end 
  
  #with String type
  let :cool_method, String do |str|
    str << "!"
  end 
end

#And now
my_class = MyClass.new
my_class.cool_method(3)     # => 300
my_class.cool_method("foo") # => foo! 
```

Class Methods
--------------

```ruby
class MyClass
  self << class
    let :cool_method, Fixnum do |f|
      f + 1
    end
    let :cool_method, String do |s|
      "{s}"
    end
  end
end 


MyClass.cool_method(1)      #=> 2
MyClass.cool_method("test") #=> "test"
```


Any Type
----------

```ruby
class MyClass 
  include Ov
  let :cool_method, Any do |any|
    any
  end 
end

my_class = MyClass.new
my_class.cool_method(1)     => 1 
my_class.cool_method("foo") => "foo"
```


Redefine methods

```ruby
class A 
  def test(str)
    p "A#test" 
  end
end

class B < A 
  include Ov
  let :test, Fixnum do |num|
    p "only for fixnum"
  end
end 

b = B.new
b.test("asd") # => A#test
b.test(123)   # => only for fixnum

```

Call method:

```ruby

class A 
  include Ov

  let :test, Fixnum do |num|
    test("#{num}") # call with string argument
  end
  
  let :test, String do |str|
    p str
  end  
end

a = A.new
a.test(123) # => "123"

```


Work with blocks

```ruby
class MyClass
  include Ov
  let :my_method, Fixnum do |num, block| # instead of |num, &block|
    p num
    block.call
  end
end

MyClass.new.my_method(1) do 
  p "123"
end
 # => 1
 # => 123
```

Examples
--------
see [link](https://github.com/fntz/ov/blob/master/samples)

## TODO

1. work with symbol method names: `+, -, *, etc` 
2. some ideas

```ruby
# multiple arguments
let :test, Integer, [String] # signature: Integer, and others must be String

let :test, Multiple #any types

let :test, :foo # Type must have :foo method

let :test, Or[Integer, String] # work for String or Integer

```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
