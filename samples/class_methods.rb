require 'ov'


class A
  include Ov
  let :test0, String do |s|
    s  
  end
  class << self
    include Ov
    
    let :test0, String do |s|
      s  
    end
    let :test0, Fixnum do |f|
      f
    end
  end
end

p A.test0("das")
p A.test0(1)
p A.new.test0("dsa")
