require 'ov'

# Array 
class MyArray 
  include Ov
  attr_accessor :arr
  

  let :initialize do
    @arr = []
  end

  let :initialize, Fixnum do |fx|
    @arr = fx.times.map { nil }
  end 

  let :initialize, Fixnum, Any do |fx, any|
    @arr = fx.times.map { any }
  end
 
end

p MyArray.new()
p MyArray.new(3)
p MyArray.new(3, true)







