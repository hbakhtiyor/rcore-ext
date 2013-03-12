require 'spec_helper'
require 'rcore_ext/string/numeric'

describe "String numeric" do
 
  let(:fix_num)      { {act: "1",              exp: 1} }
  let(:float)        { {act: "1.0",            exp: 1.0} }
  let(:not_numeric)  { {act: "1not_numeric1",  exp: nil} }
  let(:big_num)      { {act: "1" * 10,         exp: 1111111111} }

  describe "respond to numeric methods" do
	  it "should respond to is_integer? method" do
	    "".should respond_to :is_integer?
	  end

	  it "should respond to is_float? method" do
	    "".should respond_to :is_float?
	  end

	  it "should respond to is_numeric? method" do
	    "".should respond_to :is_numeric?
	  end

	  it "should respond to to_numeric method" do
	    "".should respond_to :to_numeric
	  end
	end

  describe "is_integer? method functionality" do
	  it "should be an integer value" do
	    fix_num[:act].is_integer?.should be_true
	  end

	  it "a big number should be an integer value" do
	    big_num[:act].is_integer?.should be_true
	  end

	  it "should not be an integer value" do
	    not_numeric[:act].is_integer?.should be_false
	  end

	  it "a float value should not be an integer value" do
	    float[:act].is_integer?.should be_false
	  end
	end

  describe "is_numeric? method functionality" do
	  it "should be a numeric value" do
	    fix_num[:act].is_numeric?.should be_true
	  end

	  it "a big number should be a numeric value" do
	    big_num[:act].is_numeric?.should be_true
	  end

	  it "should not be a numeric value" do
	    not_numeric[:act].is_numeric?.should be_false
	  end

	  it "a float value should be a numeric value" do
	    float[:act].is_numeric?.should be_true
	  end
	end

  describe "is_float? method functionality" do
	  it "an integer value should not be a float value" do
	    fix_num[:act].is_float?.should be_false
	  end

	  it "should not be a float value" do
	    not_numeric[:act].is_float?.should be_false
	  end

	  it "should be a float value" do
	    float[:act].is_float?.should be_true
	  end
	end

  describe "to_numeric method functionality" do
	  it "should be converted to an integer value" do
	    fix_num[:act].to_numeric.should == fix_num[:exp] 
	  end

	  it "should be converted to a float value" do
	    float[:act].to_numeric.should == float[:exp] 
	  end

	  it "should be converted to a big number value" do
	    big_num[:act].to_numeric.should == big_num[:exp]
	  end

	  it "should not be converted to numeric value" do
	    not_numeric[:act].to_numeric.should == not_numeric[:exp]
	  end
	end
end 