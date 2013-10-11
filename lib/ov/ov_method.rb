module Ov 
  class OverrideMethod # :nodoc: 
    attr_accessor :types, :body, :name, :owner, :ancestors

    # +name+ (Symbol) : name for method
    # +types+ (Array) : array with types, for method arguments
    # +body+ (Proc)   : block called with method
    def initialize(name, types, owner, body = proc{})
      @name, @types, @owner, @body = name, types, owner, body
      @ancestors = owner.ancestors.find_all do |ancestor| 
        ancestor.method_defined?(:__overridable_methods) && ancestor.class == Class
      end 
    end

    def eql?(other)
      return true if @name == other.name && @types == other.types && @owner == other.owner
      false
    end

    def eql0?(other)
      @ancestors.find{|a|  
        a.__overridable_methods.find{|m| 
          m.name == other.name && m.types == other.types 
        }
      }
    end

    def like?(other)
      return compare?(types, other.types) if @name == other.name
      false
    end

    def like0?(other)
      @ancestors.find{|a| 
        a.__overridable_methods.find{|m| 
          m.like?(other) 
        }
      }
    end

    private 
    def compare?(a, b)
      return false if a.size != b.size
      !a.zip(b).map { |arr|
        first, last = arr 
        true if (first == Ov::Any) || (last == Ov::Any) || (first == last)  
      }.include?(nil)
    end
  end
end
