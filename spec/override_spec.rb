require 'spec_helper'

describe Override do 

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
      test.str.should eq "barfoo"
      test.class.should eq TestInitialize
    end
  end

  context "exceptions" do 
    let(:test){TestException.new}
    it "throw NotImplementError when method not defined" do 
      expect { test.some_method("foo") }.to raise_error(NotImplementError)
    end
  end
  
  context "inheritance" do 
    let(:test){Test0.new}
    it "should call parent method" do 
      result = test.my_instance_method("baz")
      result.should eq "baz"
    end
    
  end

  context "call without argument" do

  end

  context "call with Any argument" do

  end

  context "call with optional arguments" do

  end
  

end




