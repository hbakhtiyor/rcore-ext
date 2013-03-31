require 'spec_helper'
require 'rcore_ext/array/compact'

describe "Array deep compact functionality" do
  describe "respond to additinal methods" do
    it "should respond to deep_compact method" do
      [].should respond_to :deep_compact
    end

    it "should respond to deep_compact! method" do
      [].should respond_to :deep_compact!
    end
  end

  describe "deep compact functionality" do
    let(:nested_nils)   { [nil, nil, [nil, 0, [nil, 1, [2, nil, nil, [[[[[nil, [[]]]]]]], 3]]], 0, 1, 2, [nil, nil, [1, 0, nil], [nil], ['  '], [], {}, 1]] }
    let(:deleted_nils)  { [[0, [1, [2, 3]]], 0, 1, 2, [[1, 0], 1]] }

    describe "not mutates itself" do
      it "should delele nested nils" do
        nested_nils.deep_compact.should == deleted_nils
      end

      it "should not mutates itself" do
        nested_nils.deep_compact
        nested_nils.should_not == deleted_nils
      end
    end

    describe "mutates itself" do
      it "should delete nested nils" do
        nested_nils.deep_compact!.should == deleted_nils
      end

      it "should return nil if no changes" do
        [1, 2, 3, [4, [5]]].deep_compact!.should be_nil
      end

      it "should not return nil if changes" do
        [1, 2, 3, [4, []]].deep_compact!.should_not be_nil
      end

      it "should mutates itself" do
        nested_nils.deep_compact!
        nested_nils.should == deleted_nils
      end
    end
  end
end