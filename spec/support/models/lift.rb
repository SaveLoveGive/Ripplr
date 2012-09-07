class Lift
  include Ripple::Document
  property :title, String
  property :description, String

  include Ripplr::Queryable
  queryable do
    text :title, :description
  end
end
