module Override 
  class OverrideMethod # :nodoc: 
    attr_accessor :types, :body, :name, :owner

    # +name+ (Symbol) : name for method
    # +types+ (Array) : array with types, for method arguments
    # +body+ (Proc)   : block called with method
    def initialize(name, types, owner, body)
      @name, @types, @owner, @body = name, types, owner, body
    end
  end
end
