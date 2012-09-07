module Ripplr
  module Formatters
    class Riak
      def self.to_index(queryable_obj)
        raise Ripplr::KeyNotSpecifiedError.new unless queryable_obj.respond_to?(:key)

        # index_data = { :id => queryable_obj.key }

        # queryable_obj.class.query_fields.each do |field|
        #   index_data.merge field.indexes_as(queryable_obj)
        # end

        
      end
    end
  end
end
