# Ov

Create a multimethods in Ruby

## Installation

Add this line to your application's Gemfile:

    gem 'ov'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ov

## Usage

Firstly include `Ov` in you class

```ruby 
class MyClass 
  include Ov 
end
```

After define method with types:

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
see [link](https://github.com/fntzr/ov/blob/master/samples)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
