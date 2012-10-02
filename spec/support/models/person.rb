class Person
  include Ripple::Document
  property :first_name, String
  property :last_name, String
  property :middle_name, String
  timestamps!

  include Ripplr::Queryable
  queryable do
    text :first_name, :last_name
    time :created_at
  end
end
