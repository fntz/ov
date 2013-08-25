class Test
  include Override
  
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
  undef :initialize
  include Override
  attr_reader :str
  let :this, String do |str|
    str << "foo"
    @str = str
  end
end

class TestException
  include Override
end

class Test0 < Test 
  let :my_instance_method, String do |str| 
    "foo"
  end
end