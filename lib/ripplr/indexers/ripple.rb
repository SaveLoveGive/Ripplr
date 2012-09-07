module Ripplr
  module Indexers
    class Ripple
      def self.index(queryable_obj, formatter=Ripplr::Formatters::Json)
        ::Ripple.client.index queryable_obj.bucket_name, formatter.to_index(queryable_obj)
      end
    end
  end
end
