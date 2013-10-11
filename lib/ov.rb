require "ov/version"
require "ov/ov_array"
require "ov/ov_method"
require "ov/ov_any"
require "ov/exception"


##
# `Ov` module provides functional for creating methods 
# with types in Ruby.
#
#
# == Usage
#   
# Firstly include `Ov` in you class
#  
#   class MyClass        
#     include Ov 
#   end
#
# After define method with types:
#   
#   class MyClass
#     include Ov   
#     
#     # with Fixnum type 
#     let :cool_method, Fixnum do |num|
#       num * 100
#     end 
#     
#     # with String type
#     let :cool_method, String do |str|
#       str << "!"
#     end 
#   end
#   
# And now
#      
#   my_class = MyClass.new
#   my_class.cool_method(3)     # => 300
#   my_class.cool_method("foo") # => foo!  
# 
# == Any Type
#  
#   class MyClass 
#     include Ov
#     let :cool_method, Any do |any|
#       any
#     end 
#   end
#   
#   my_class = MyClass.new
#   my_class.cool_method(1)     # => 1 
#   my_class.cool_method("foo") # => "foo"
#
# Is the same so ruby `def` 
#
#
module Ov
  def self.included(base) # :nodoc:
    base.extend(self)
    base.class_eval do
      class_variable_set(:@@__overridable_methods, OA.new)
    end
  end

  def __overridable_methods # :nodoc:
    send(:class_variable_get, :@@__overridable_methods)
  end

  ##
  # Create new method with +name+ and +types+
  # When method called +block+ will be executed
  #
  # +name+ is symbol
  #
  # +types+ types for method
  #
  def let(name, *types, &block)
    
    __overridable_methods << OverrideMethod.new(name, types, self, block)
    
    if !self.method_defined?(name)
      self.instance_exec do
        self.send(:define_method, name) do |*args, &block|
          types = *args.map(&:class)
          owner = self.class
            
          method = OverrideMethod.new(name, types, owner) 

          z = owner.__overridable_methods.where(method)
          raise NotImplementError.new("Method `#{name}` in `#{self}` class with types `#{types}` not implemented.") if z.nil?
          instance_exec(*args, &z.body)  
        end
      end
    end   
  end
end



