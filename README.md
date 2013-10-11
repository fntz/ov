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

Examples
--------
see [link](https://github.com/fntzr/ov/blob/master/samples/example.rb)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
