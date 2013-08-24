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
