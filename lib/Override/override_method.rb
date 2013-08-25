module Override
  class OverrideMethod 
    attr_accessor :types, :body, :name, :location

    # name (Symbol) : name for method
    # types (Array) : array with types, for method arguments
    # body (Proc)   : block called with method
    def initialize(name, types, localtion, body)
      @name, @types, @body = name, types, body
    end
  end
end
