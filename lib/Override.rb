require "Override/version"
require "Override/override_method"

class NotImplementError < Exception
end

module Override
  def self.included(base)
    base.extend(self)
    base.class_eval do 
      class_variable_set(:@@__overridable_methods, [])
    end
  end

  def __overridable_methods 
    class_variable_get(:@@__overridable_methods)
  end

  def let(name, *types, &block)
    #__overridable_methods.delete_if{|_| 
    #  _.name == name && _.types == types
    #}
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
    
    z = _ms.find{|_| _.types == types and _.owner == owner} ||
        _ms.find{|_| _.types == types and _.owner == parent} 

    raise NotImplementError.new("Method `#{method}` in `#{owner}` class with types `#{types}` not implemented.") if z.nil?

    _block = z.body
    instance_exec(*args, &_block)
  end
end



