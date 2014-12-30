require 'spec_helper'

describe Ov::Ext do 

  include Ov::Ext

  it "#match method" do 
    result = match("String", [123]) do 
      try(String, Array) {|str, arr| 1 }
      try(String) {|str| 2  }
      otherwise { 3 }
    end
    
    expect(result).to eq(1)
  end
end



