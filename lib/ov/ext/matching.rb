module Ov
  module Ext
    #
    # Add `match` method, which work like `case` statement but for types
    #
    # == Usage
    # 
    #    include Ov::Ext    
    #    
    #    match("String", "dsa") do 
    #      try(String, Array) {|str, arr| "#{str} #{arr}" }
    #      try(String) {|str| "#{str}"  }
    #      otherwise { "none" }
    #    end  
    #
    #
    def match(*args, &block)
      z = Module.new do 
        include Ov
        extend self
        def try(*args, &block)
          let :anon_method, *args, &block
        end
        def otherwise(&block)
          let :otherwise, &block
        end
        instance_eval &block
      end
      begin
        z.anon_method(*args)
      rescue Ov::NotImplementError => e 
        z.otherwise
      end  
    end
  end
end  


