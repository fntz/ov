require "ov/version"
require "ov/ov_array"
require "ov/ov_method"
require "ov/ov_any"
require "ov/exception"
require 'ov/ext/matching'

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
#   my_class.cool_method(1) 
#     => 1 
#   my_class.cool_method("foo") # => "foo"
#
# Is the same so ruby `def` 
#
#
# == Define as class methods
# 
#   class MyClass
#     self << class
#       let :cool_method, Fixnum do |f|
#         f + 1
#       end
#       let :cool_method, String do |s|
#         "{s}"
#       end
#     end
#   end 
#
#
#   MyClass.cool_method(1)      #=> 2
#   MyClass.cool_method("test") #=> "test"
#
#
# == Work with blocks
# 
# Blocks, should be pass given without ampersand (&)
#
#   class MyClass
#    
#     let :my_method, Fixnum do |num, block| # instead of |num, &block|
#       p num
#       block.call
#     end
#
#   end
#
#   MyClass.new.my_method(1) do 
#     p "123"
#   end
#   # => 1
#   # => 123
module Ov
  
  def self.included(base) # :nodoc:
    base.extend(self)
    base.class_eval do
      class_variable_set(:@@__overload_methods, OA.new) if !class_variable_defined?(:@@__overload_methods)
    end
  end
  
  def __overload_methods # :nodoc:
    send(:class_variable_get, :@@__overload_methods)
  end
  
  private :__overload_methods
  ##
  # Create new method with +name+ and +types+
  # When method called +block+ will be executed
  #
  # +name+ is symbol
  #
  # +types+ types for method
  #
  def let(name, *types, &block)
    included = false 
      
    if self.instance_methods.include?(name)
      included = true
      class_eval "alias :ov_old_#{name.to_s} #{name}"
      undef_method name
    end   
    
    __overload_methods << OverrideMethod.new(name, types, self, block)
    
    if !self.method_defined?(name)
      self.instance_exec do
        message = if self.class == Module
          :define_singleton_method
        else
          :define_method
        end
        
        self.send(message, name) do |*args, &block|
          types = *args.map(&:class)
          owner = need_owner()
          
          method = OverrideMethod.new(name, types, owner) 
          z = owner.send(:__overload_methods).where(method) 
          
          if z.nil?
            if included
              send("ov_old_#{name.to_s}", *args, &block)
            else 
              raise Ov::NotImplementError.new("Method `#{name}` in `#{self}` class with types `#{types.join(', ')}` not implemented.") 
            end
          else 
            k = *args
            k << block if !block.nil? 
            instance_exec(*k, &z.body)   
          end
        end
      end
    end   
  end

  #
  # return all defined with +let+ methods.
  # 
  def multimethods()
    owner = need_owner()
    owner.send(:__overload_methods).map do |method|
      [method.name, method.types] if method.owner == owner  
    end.compact
  end


  private 
    def need_owner #:nodoc:
      if self.class == Module
          self
        elsif self.respond_to?(:ancestors) && self == ancestors.first
          self.singleton_class
        else
          self.class
        end
    end
end



