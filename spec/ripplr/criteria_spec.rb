require 'spec_helper'

describe Ripplr::Criteria do

  describe "searching without a query" do
    Given { Person.stub(:list).and_return [1,2,3,4,5] }
    When(:results) { Ripplr::Criteria.new(Person).execute }
    Then { results.should == [1,2,3,4,5] }
  end

  describe "searching with a query against a field" do
    Given (:indexer) { mock }
    Given { indexer.should_receive(:search).with(Person,"first_name_text: \"skrillex\"").and_return ["Awesome"] }
    When (:results) { Ripplr::Criteria.new(Person, indexer).where(:first_name => "skrillex").execute }
    Then { results.should == ["Awesome"] }
  end

  describe "searching with a query against a different field" do
    Given (:indexer) { mock }
    Given { indexer.should_receive(:search).with(Person,"last_name_text: \"Auerbach\"").and_return ["Dan"] }
    When (:results) { Ripplr::Criteria.new(Person, indexer).where(:last_name => "Auerbach").execute }
    Then { results.should == ["Dan"] }
  end

  describe "building a query with unqueryable fields" do
    Then { expect { Ripplr::Criteria.new(Person).where(:bangarang => 'yes sir') }.to raise_error RuntimeError }
  end

  describe "treating a criteria object like a collection executes the query" do
    Given (:criteria) {  Ripplr::Criteria.new(Person, indexer).where(:first_name => "Dan") }
    Given (:indexer) { mock }
    Given { indexer.should_receive(:search).with(Person,"first_name_text: \"Dan\"").once.and_return(["Dan"]) }

    context "by calling #each" do
      Given (:iterated) { Array.new }
      When { criteria.each {|p| iterated << p } }
      Then { iterated.should == ["Dan"] }
    end

    context "by calling #each twice only calls execute once" do
      Given (:iterated) { Array.new }
      Given { criteria.each {|p| p } }
      When { criteria.each {|p| iterated << p } }
      Then { iterated.should == ["Dan"] }
    end

    context "by calling #size" do
      Then { criteria.size.should == 1 }
    end

    context "by calling #length" do
      Then { criteria.length.should == 1 }
    end

    context "by calling #count" do
      Then { criteria.count.should == 1 }
    end
  end

end
