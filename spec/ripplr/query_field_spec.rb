require 'spec_helper'

describe Ripplr::QueryField do
  context "when text field and property is set" do
    Given (:john) { Person.new :first_name => 'John' }
    Given (:query_field) { Ripplr::QueryField.new :text, :first_name }
    When (:result) { query_field.indexes_as john  }
    Then { result[:first_name_text].should == 'John' }
  end
end
