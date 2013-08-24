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

end




