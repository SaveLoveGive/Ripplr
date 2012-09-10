# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ripplr::Queryable do
  context "when ripplr::queryable is included" do
    Given (:a_class) { class AClass; include Ripplr::Queryable; end }
    Then { a_class.included_modules.should include(Ripplr::Queryable) }
    Then { a_class.new.should respond_to(:index) }
    Then { a_class.new.should respond_to(:remove_index) }
    Then { a_class.new.should respond_to(:bucket_name) }
  end

  describe "#bucket_name" do
    Given { Person.bucket.should_receive(:name).and_return "people" }
    Then { Person.new.bucket_name.should == "people" }
  end

  describe "#find" do
    context "when using a field that has been defiend as queryable" do
      Given (:indexer) { mock }
      Given { indexer.should_receive(:search).with(:first_name_text, "Dan").and_return ["Dan Auerbach"] }
      When (:result) { Person.find :first_name, "Dan", indexer }
      Then { result.should == [ "Dan Auerbach" ] }
    end

    context "when using a field that has not been defined as queryable" do
      Then { expect { Person.find :full_name, "val" }.to raise_error RuntimeError }
    end

    context "when the object does not have any queryable fields" do
      Then { expect { Unqueryable.find :something, "what what" }.to raise_error RuntimeError }
    end
  end

  describe "#index" do
    context "overide indexer" do
      Given (:friend) { Person.new }
      Given (:service) { mock :index => true }
      Then { friend.index(service).should be_true }
    end
    context "default indexer" do
      Given (:rg3) { Person.new }
      Given { Ripplr::Indexers::Ripple.should_receive(:index).with(rg3).and_return true }
      Then { rg3.index.should be_true }
    end
  end

  describe "#indexes_as" do
    context "when the object is queryable and has text fields" do
      Given (:lawnmower) { Lift.new :title => "Lawnmower", :description => "It’s a variation of the classic dumbbell row so it trains the muscles of your back." }
      Given { lawnmower.stub(:key).and_return "ABCDEF012345" }
      When (:result) { lawnmower.indexes_as }
      Then { result.should == {
          :id => "ABCDEF012345",
          :title_text => "Lawnmower",
          :description_text => "It’s a variation of the classic dumbbell row so it trains the muscles of your back."
        }
      }
    end

    context "when the object is queryable and has text and date fields" do
      Given (:entry) { LogEntry.new :description => "4x8 BB Power Clean @ 135lbs." }
      Given (:time) { Time.now }
      Given { entry.stub(:created_at).and_return time }
      Given { entry.stub(:key).and_return "XYZ1020" }
      When (:result) { entry.indexes_as }
      Then { result.should == {
          :id => "XYZ1020",
          :description_text => "4x8 BB Power Clean @ 135lbs.",
          :created_at_dt => time
        }
      }
    end
  end
end
