require 'spec_helper'
require 'rcore_ext/hash/compact'

describe "Hash additinal functionality" do
  describe "respond to additinal methods" do
    it "should respond to compact method" do
      {}.should respond_to :compact
    end

    it "should respond to compact! method" do
      {}.should respond_to :compact!
    end

    it "should respond to deep_compact method" do
      {}.should respond_to :deep_compact
    end

    it "should respond to deep_compact! method" do
      {}.should respond_to :deep_compact!
    end
  end

  describe "compact functionality" do
    let(:nils)      { { nil => 0, 0 => nil, 1 => 1 } }
    let(:nils_pair) { { nil => nil, 0 => nil, 1 => 1 } }

    let(:delete_keys)   { { 0 => nil, 1 => 1 } }
    let(:delete_values) { { nil => 0, 1 => 1 } }
    let(:delete_both)   { { 1 => 1 } }
    let(:delete_pair)   { { 0 => nil, 1 => 1 } }

    describe "not mutates itself" do
      it "with keys options" do
        nils.compact(:keys).should == delete_keys 
      end

      it "with values option" do
        nils.compact(:values).should == delete_values
      end

      it "with both option" do
        nils.compact(:both).should == delete_both
      end

      it "with pair option" do
        nils_pair.compact.should == delete_pair
      end

      it "should not mutates itself" do
        nils_pair.compact
        nils_pair.should_not == delete_pair
      end
    end

    describe "mutates itself" do
      it "with keys options" do
        nils.compact!(:keys).should == delete_keys 
      end

      it "with values option" do
        nils.compact!(:values).should == delete_values
      end

      it "with both option" do
        nils.compact!(:both).should == delete_both
      end

      it "with pair option" do
        nils_pair.compact!.should == delete_pair
      end

      it "should return nil if no changes" do
        {a: :b}.compact!.should be_nil
      end

      it "should mutates itself" do
        nils_pair.compact!
        nils_pair.should == delete_pair
      end
    end
  end

  describe "deep compact functionality" do
    let(:nested_nils)       { { nil => 0, 0 => nil, 2 => { nil => 0, 3 => { nil => 1, 4 => { nil => 0, 1 => nil }, 
                              1 => nil, 2 => 2, 3 => nil }, 0 => nil, 1 => 0, 2 => nil }, 1 => 1 } }
    let(:nested_key_nils_1) { { { nil => 0 } => { nil => nil }, nil => 0, 0 => nil, 2 => { nil => 0, 3 => { nil => 1, 4 => { nil => nil, 1 => nil }, 
                              1 => nil, 2 => 2, 3 => nil }, 0 => nil, 1 => 0, 2 => nil }, 1 => 1 } }
    let(:nested_key_nils_2) { { 1 => 2, { nil => 1 } => { 2 => nil, nil => 1 } } }
    let(:nested_nils_pair)  { { nil => nil, 2 => { 3 => { nil => nil, 0 => nil }, nil => nil, 0 => nil }, 0 => nil, 1 => 1 } }

    let(:delete_keys)   { { 0 => nil, 2 => { 3 => { 4 => { 1 => nil }, 1 => nil, 2 => 2, 3 => nil }, 0 => nil, 1 => 0, 2 => nil }, 1 => 1 } }
    let(:delete_values) { { nil => 0, 2 => { nil => 0, 3 => { nil => 1, 4 => { nil => 0 }, 2 => 2 }, 1 => 0 }, 1 => 1 } }
    let(:delete_both)   { { 2 => { 3 => { 2 => 2 }, 1 => 0 }, 1 => 1 } }
    let(:delete_pair)   { { 2 => { 3 => { 0 => nil }, 0 => nil }, 0 => nil, 1 => 1 } }

    describe "not mutates itself" do
      it "with keys option" do
        nested_nils.deep_compact(:keys).should == delete_keys 
      end

      it "first nested key with keys option" do
        nested_key_nils_1.deep_compact(:keys).should == delete_keys        
      end

      it "second nested key with keys option" do
        nested_key_nils_2.deep_compact(:keys).should == {1 => 2}        
      end

      it "second nested key with both option" do
        nested_key_nils_2.deep_compact(:both).should == {1 => 2}        
      end

      it "with values option" do
        nested_nils.deep_compact(:values).should == delete_values
      end

      it "with both option" do
        nested_nils.deep_compact(:both).should == delete_both
      end

      it "with pair option" do
        nested_nils_pair.deep_compact.should == delete_pair
      end

      it "should not mutates itself" do
        nested_nils_pair.deep_compact
        nested_nils_pair.should_not == delete_pair
      end      
    end

    describe "mutates itself" do
      it "with keys option" do
        nested_nils.deep_compact!(:keys).should == delete_keys 
      end

      it "first nested key with keys option" do
        pending
        nested_key_nils_1.deep_compact!(:keys).should == delete_keys        
      end

      it "second nested key with keys option" do
        pending
        nested_key_nils_2.deep_compact!(:keys).should == {1 => 2}        
      end

      it "second nested key with both option" do
        pending
        nested_key_nils_2.deep_compact!(:both).should == {1 => 2}        
      end

      it "with values option" do
        nested_nils.deep_compact!(:values).should == delete_values
      end

      it "with both option" do
        nested_nils.deep_compact!(:both).should == delete_both
      end

      it "with pair option" do
        nested_nils_pair.deep_compact!.should == delete_pair
      end

      it "should return nil if no changes" do
        {a: :b, c: {d: {e: :f}}}.deep_compact!.should be_nil
      end

      it "should not return nil if changes" do
        {a: :b, c: {d: {nil => nil}}}.deep_compact!.should_not be_nil
      end

      it "should mutates itself" do
        nested_nils_pair.deep_compact!
        nested_nils_pair.should == delete_pair
      end      
    end
  end
end