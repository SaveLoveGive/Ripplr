require 'spec_helper'

describe Ripplr::Indexers::Ripple do

  describe "#index" do
    Given (:model) { mock :bucket_name => 'my_bucket', :indexes_as => 'some json' }
    Given { Ripple.client.should_receive(:index).with('my_bucket', 'some json').and_return true }
    Then { Ripplr::Indexers::Ripple.index(model).should be_true }
  end

  describe "#search" do
    context "when no documents match" do
      Given (:results) { {"response" => {"docs" => []} }  }
      Given { Ripple.client.should_receive(:search).with('people', 'query string').and_return results }
      When(:result) { Ripplr::Indexers::Ripple.search Person, 'query string' }
      Then { result.should be_empty }
    end

    context "when one document matches" do
      Given (:results) { {"response" => {"docs" => [ { "id" => "12345"} ]} }  }
      Given { Person.should_receive(:find).with("12345").and_return "yo dawg" }
      Given { Ripple.client.should_receive(:search).with('people', 'query string').and_return results }
      When(:result) { Ripplr::Indexers::Ripple.search Person, 'query string' }
      Then { result.first.should == "yo dawg" }
    end

    context "when one document matches but it doesnt exist" do
      Given (:results) { {"response" => {"docs" => [ { "id" => "12345"} ]} }  }
      Given { Person.should_receive(:find).with("12345").and_return nil }
      Given { Ripple.client.should_receive(:search).with('people', 'query string').and_return results }
      When(:result) { Ripplr::Indexers::Ripple.search Person, 'query string' }
      Then { result.should be_empty }
    end
  end
end


## EXAMPLE SEARCH RESULT ##
###########################
# {"responseHeader"=>
# {"status"=>0, "QTime"=>2, "params"=>{"q"=>"title_text: Skrillex", "q.op"=>"or", "filter"=>"", "wt"=>"json"}},
# {"response" =>
# {
#   "numFound"=>3,
#   "start"=>0,
#   "maxScore"=>"0.353553",
#   "docs"=>[
#            { "id"=>"GDdq2m1xI2URV34HTWC1UfBRC3n",
#              "index"=>"vera_access_checklists",
#              "fields"=>
#              {"created_at_dt"=>"2012-09-06 19:17:20 UTC",
#                "title_text"=>"skrillex"},
#              "props"=>{}} ]
# }
