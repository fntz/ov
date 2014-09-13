require 'spec_helper'

class A
  extend Ov
  
  
end


describe Ov do 
  context "instance methods" do 
    context "#my_instance_method" do 
      let(:test){Test.new}
      
      it "return array" do 
        result = test.my_instance_method(["foo", "bar"], "baz")
        result.should eq ["foo", "bar", "baz"]
      end

     it "return string" do 
        result = test.my_instance_method("baz")
        result.should eq "baz"
     end

      it "return overridable method" do
        result = test.my_instance_method(1)
        result.should eq ["bar"]
      end
    end
  end

  context "override initialize method" do
    it "return new instance with #this method" do 
      test = TestInitialize.new("bar")
      test.arg.should eq "barfoo"
      test.class.should eq TestInitialize
    
      test0 = TestInitialize.new(1)
      test0.arg.should eq 100
      test0.class.should eq TestInitialize
    end
  end

  context "exceptions" do 
    let(:test){TestException.new}
    it "throw NotImplementError when method not defined" do 
      expect { test.some_method("foo") }.to raise_error(Ov::NotImplementError)
    end
  end

  context "inheritance" do 
    let(:test){Test0.new}
    it "should call parent method" do 
      result = test.my_instance_method(["foo", "bar"], "baz")
      result.should eq ["foo", "bar", "baz"]
    end
    it "should call own method" do 
      result = test.my_instance_method("baz")
      result.should eq "foo"
    end
  end

  
  context "call without argument" do
    let(:test) {TestWithoutArguments.new}
    it do 
      result = test.my_instance_method
      result.should eq "foo"
    end
  end
 
  context "call with Any argument" do
    let(:test) {TestAny.new}
    it do 
      test.my_instance_method(1).should eq 1
      test.my_instance_method("foo").should eq "foo"
      test.my_instance_method(:foo).should eq :foo
    end
  
    it "exception when many arguments or without arguments" do 
      expect{ test.my_instance_method(1,2,3)}.to raise_error(Ov::NotImplementError)
      expect{ test.my_instance_method()}.to raise_error(Ov::NotImplementError)
    end   
  end 
     
  describe "#for module" do
    context "#my_instance_method" do 
      let(:test){TestModule}
      
      it "return array" do 
        result = test.my_instance_method(["foo", "bar"], "baz")
        result.should eq ["foo", "bar", "baz"]
      end

     it "return string" do 
        result = test.my_instance_method("baz")
        result.should eq "baz"
     end

      it "return overridable method" do
        result = test.my_instance_method(1)
        result.should eq ["bar"]
      end
    end      
  end
  
  describe "#let class methods" do
    context "#my_instance_method" do 
      let(:test){TestSingletonClass}
      let(:test_ins){TestSingletonClass.new}
      
      it "return array" do 
        result = test.my_instance_method(["foo", "bar"], "baz")
        result.should eq ["foo", "bar", "baz"]
      end

      it "return string" do 
        result = test.my_instance_method("baz")
        result.should eq "baz"
      end

      it "return overridable method" do
        result = test.my_instance_method(1)
        result.should eq ["bar"]
      end
      
      it "instance return string" do 
        result = test_ins.my_instance_method("baz")
        result.should eq "baz"
      end
      
      it "exception when not defined" do 
        expect{ test_ins.my_instance_method(1,2,3)}.to raise_error(Ov::NotImplementError)
     end
    end
  end
end




