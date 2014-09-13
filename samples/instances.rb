require "ov"

class A 
  def test(str)
    p "A#test" 
  end

  def self.class_test(str)
    p "A#class_test"
  end
end

class B < A 
  include Ov
  let :test, Fixnum do |num|
    p "only for fixnum"
  end

  class << self 
    include Ov 

    let :class_test, Fixnum do |num|
      p "class method for fixnum"
    end
  end
end 

b = B.new
b.test("asd") # => A#test
b.test(123)   # => only for fixnum

B.class_test("asd") # => "A#class_test"
B.class_test(123) # => "class method for fixnum"
 