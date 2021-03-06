class Test
  include Ov
  
  let :my_instance_method, Array, String do |arr, str|
    arr << str
    arr
  end  
  
  let :my_instance_method, String do |str| 
    str
  end

  let :my_instance_method, Integer do |fixnum|
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
  let :initialize, Integer do |fx|
    @arg = fx*100
  end
end


class TestException
  include Ov
  let :some_method, Integer do |fx|
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

class TestSingletonClass
  include Ov
  let :my_instance_method, String do |str| 
    str
  end
  
  class << self
    include Ov
    
    let :my_instance_method, Array, String do |arr, str|
      arr << str
      arr
    end  
    
    let :my_instance_method, String do |str| 
      str
    end
  
    let :my_instance_method, Integer do |fixnum|
      my_instance_method([], my_instance_method("bar"))
    end
  end    
end

module TestModule
  include Ov
  
  
  let :my_instance_method, Array, String do |arr, str|
    arr << str
    arr
  end  
  
  let :my_instance_method, String do |str| 
    str
  end

  let :my_instance_method, Integer do |fixnum|
    my_instance_method([], my_instance_method("bar"))
  end 
end

class ClassWithBlock
  include Ov
   

  let :test, Integer do |num, block|
    num + block.call
  end

  class << self 
    include Ov
    let :test, String do |str, block|
      str << block.call 
    end
  end
end