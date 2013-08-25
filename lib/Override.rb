require "Override/version"

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
    __overridable_methods << [name, types, block]
  end

  def method_missing(method, *args, &block)
    types = *args.map(&:class)
    z = self.class.__overridable_methods.find_all{|_| _.first == method}.find{|_| _[1] == types}
    raise NotImplementError.new("Method `#{method}` with types `#{types}` not implemented.") if z.nil?

    _, _, _block = z
    instance_exec(*args, &_block)
  end
end



