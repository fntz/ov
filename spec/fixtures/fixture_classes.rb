class Test
  include Ov
  
  let :my_instance_method, Array, String do |arr, str|
    arr << str
    arr
  end  
  
  let :my_instance_method, String do |str| 
    str
  end

  let :my_instance_method, Fixnum do |fixnum|
    my_instance_method([], my_instance_method("bar"))
  end  
end

class TestInitialize
  include Ov
  attr_reader :arg 
  let :initialize, String do |str|
    str << "foo"
    @arg = str
  end
  let :initialize, Fixnum do |fx|
    @arg = fx*100
  end
end


class TestException
  include Ov
  let :some_method, Fixnum do |fx|
  end
end

class Test0 < Test 
  let :my_instance_method, String do |str| 
    "foo"
  end
end

class TestWithoutArguments 
  include Ov
  let :my_instance_method do 
    "foo"
  end
end

class TestAny
  include Ov
  let :my_instance_method, Any do |any| 
    any
  end
end

module TestModule
  include Ov
  extend self
  
  let :my_instance_method, Array, String do |arr, str|
    arr << str
    arr
  end  
  
  let :my_instance_method, String do |str| 
    str
  end

  let :my_instance_method, Fixnum do |fixnum|
    my_instance_method([], my_instance_method("bar"))
  end 
end

