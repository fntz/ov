require 'ov'


module SO
  def self.get(request)
    if Random.rand(10) > 6 
      Result.new("#{request}")
    else 
      Fail.new
    end
  end
end

class Result
  attr_accessor :string
  def initialize(string)
    @string = string
  end

  alias :[] :string  
end
class Fail
end

class M 
  include Ov
  
  let :process, Fail do ; [] end 
  let :process, Result do |r| ; r[] ; end
end


m = M.new
10.times { |i|
  p m.process(SO.get("#{i}"))
}