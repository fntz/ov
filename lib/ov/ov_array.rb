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
      return self if @complete
      ev_block = yield(method)
      @complete, @result = true, ev_block if ev_block
      self
    end

    alias :get :result
  end
end