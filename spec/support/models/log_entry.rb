class LogEntry
  include Ripple::Document
  property :created_at, Time
  property :description, String

  include Ripplr::Queryable
  queryable do
    text :description
    time :created_at
  end
end
