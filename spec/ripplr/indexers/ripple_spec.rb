require 'spec_helper'

describe Ripplr::Indexers::Ripple do

  describe "#index" do
    Given (:model) { mock :bucket_name => 'my_bucket', :indexes_as => 'some json' }
    Given { Ripple.client.should_receive(:index).with('my_bucket', 'some json').and_return true }
    Then { Ripplr::Indexers::Ripple.index(model).should be_true }
  end

  
end
