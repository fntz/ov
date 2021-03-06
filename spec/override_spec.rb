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
        expect(result).to eq(["foo", "bar", "baz"])
      end

     it "return string" do 
        result = test.my_instance_method("baz")
        expect(result).to eq "baz"
     end

      it "return overload method" do
        result = test.my_instance_method(1)
        expect(result).to eq ["bar"]
      end

      it "return all let methods" do 
        expect(test.multimethods.size).to eq(3)
      end
    end
  end

  context "overload initialize method" do
    it "return new instance with #this method" do 
      test = TestInitialize.new("bar")
      expect(test.arg).to eq "barfoo"
      expect(test.class).to eq TestInitialize
    
      test0 = TestInitialize.new(1)
      expect(test0.arg).to eq 100
      expect(test0.class).to eq TestInitialize

      expect(test.multimethods.size).to eq(2)
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
      expect(result).to eq ["foo", "bar", "baz"]
    end
    it "should call own method" do 
      result = test.my_instance_method("baz")
      expect(result).to eq "foo"
    end
    it "should return multimethods" do 
      expect(test.multimethods.size).to eq(1)
    end
  end

  
  context "call without argument" do
    let(:test) {TestWithoutArguments.new}
    it do 
      result = test.my_instance_method
      expect(result).to eq "foo"
    end
  end
 
  context "call with Any argument" do
    let(:test) {TestAny.new}
    it do 
      expect(test.my_instance_method(1)).to eq 1
      expect(test.my_instance_method("foo")).to eq "foo"
      expect(test.my_instance_method(:foo)).to eq :foo
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
        expect(result).to eq ["foo", "bar", "baz"]
      end

     it "return string" do 
        result = test.my_instance_method("baz")
        expect(result).to eq "baz"
     end

      it "return overload method" do
        result = test.my_instance_method(1)
        expect(result).to eq ["bar"]
      end

      it "multimethods" do 
        expect(test.multimethods.size).to eq(3)
      end
    end      
  end
  
  describe "#let class methods" do
    context "#my_instance_method" do 
      let(:test){TestSingletonClass}
      let(:test_ins){TestSingletonClass.new}
      
      it "return array" do 
        result = test.my_instance_method(["foo", "bar"], "baz")
        expect(result).to eq ["foo", "bar", "baz"]
      end

      it "return string" do 
        result = test.my_instance_method("baz")
        expect(result).to eq "baz"
      end

      it "return overload method" do
        result = test.my_instance_method(1)
        expect(result).to eq ["bar"]
      end
      
      it "instance return string" do 
        result = test_ins.my_instance_method("baz")
        expect(result).to eq "baz"
      end
      
      it "exception when not defined" do 
        expect{ test_ins.my_instance_method(1,2,3)}.to raise_error(Ov::NotImplementError)
     end

     it "multimethods" do 
       expect(test.multimethods.size).to eq(3)
       expect(test_ins.multimethods.size).to eq(1)
     end
    end
  end

  describe "work with blocks" do 
    let(:instance){ClassWithBlock.new}
    let(:klass){ClassWithBlock}

    it "should pass block in instance method" do 
      result = instance.test(3) do 
        3
      end
      expect(result).to eq(6)
    end

    it "should pass block in class method" do 
      result = klass.test("foo") do 
        "bar"
      end
      expect(result).to eq("foobar") 
    end
  end

end




