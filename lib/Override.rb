require "Override/version"
require "Override/override_method"
require "Override/override_any"
require "Override/exception"


module Override
  def self.included(base) #:nodoc:
    base.extend(self)
    base.class_eval do 
      class_variable_set(:@@__overridable_methods, [])
    end
  end

  def __overridable_methods 
    class_variable_get(:@@__overridable_methods)
  end

  def let(name, *types, &block)
    __overridable_methods << OverrideMethod.new(name, types, self, block)
  end

  def method_missing(method, *args, &block)
    types = *args.map(&:class)
    method = :this if method == :initialize
    
    #first find in class
    #after in parent class
    owner, parent = self.class, self.class.superclass

    _ms = owner.__overridable_methods
             .find_all{|_| _.name == method}
    
    compare = lambda do |a, b| 
      return false if a.size != b.size
      !a.zip(b).map do |arr| 
        first, last = arr 
        true if (first == Override::Any) || (last == Override::Any) || (first == last)  
      end.include?(nil)
    end  
    
    z = _ms.find{|_| compare[_.types, types] and _.owner == owner} ||
        _ms.find{|_| compare[_.types, types] and _.owner == parent} 

        
    raise NotImplementError.new("Method `#{method}` in `#{owner}` class with types `#{types}` not implemented.") if z.nil?

    _block = z.body
    instance_exec(*args, &_block)
  end
end



