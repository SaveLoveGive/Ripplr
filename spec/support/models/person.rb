class Person
  include Ripple::Document
  property :first_name, String
  property :last_name, String

  include Ripplr::Queryable
  queryable do
    text :first_name, :last_name
  end
end
