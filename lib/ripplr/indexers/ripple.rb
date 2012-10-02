module Ripplr
  module Indexers
    class Ripple
      def self.index(queryable_obj)
        ::Ripple.client.index queryable_obj.bucket_name, queryable_obj.indexes_as
      end

      def self.search(klass, query, options={})
        results = ::Ripple.client.search(klass.bucket.name, query, options)["docs"]
        results.map{|result| klass.find(result["id"])}.reject{|obj| obj.nil?}
      end
    end
  end
end
