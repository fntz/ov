module Ov
  class OA < Array 
    attr_accessor :complete, :result
    #find in self
    #find in ancestors
    #find types
    #find any types
    def where(method)
      @complete, @result = nil, nil
      z = find_or_next(method) { |method| 
        self.find{|m| m.eql?(method) }
      }.find_or_next(method) { |method|
        self.find{|m| m.eql0?(method) }
      }.find_or_next(method) { |method|
        self.find{|m| m.like?(method) }
      }.find_or_next(method) {|method| 
        self.find{|m| m.like0?(method) }
      }.get
    end

    def find_or_next(method, &block)
      ev_block = yield(method)
      if ev_block && !@complete
        @complete, @result = true, ev_block
      end
      self
    end

    alias :get :result

    private 
    
    def compare(a, b)
      return false if a.size != b.size
      !a.zip(b).map do |arr| 
        first, last = arr 
        true if (first == Ov::Any) || (last == Ov::Any) || (first == last)  
      end.include?(nil)
    end

    def compare0(a, b)

    end
  end
end