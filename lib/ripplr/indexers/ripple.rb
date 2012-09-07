module Ripplr
  module Indexers
    class Ripple
      def self.index(queryable_obj)
        ::Ripple.client.index queryable_obj.bucket_name, queryable_obj.indexes_as
      end
    end
  end
end
