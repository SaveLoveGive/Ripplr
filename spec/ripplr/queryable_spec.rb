require 'spec_helper'

describe Ripplr::Queryable do
  context "when ripplr::queryable is included" do
    Given (:a_class) { class AClass; include Ripplr::Queryable; end }
    Then { a_class.included_modules.should include(Ripplr::Queryable) }
    Then { a_class.new.should respond_to(:index) }
    Then { a_class.new.should respond_to(:remove_index) }
    Then { a_class.new.should respond_to(:bucket_name) }
  end


  describe "#indexing" do
    Given (:friend) { Person.new }
    Given (:service) { mock :index => true }
    Then { friend.index(service).should be_true }
  end

end
