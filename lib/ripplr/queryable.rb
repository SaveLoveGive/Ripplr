module Ripplr
  module Queryable
    def index(indexer=Ripple.client)
      indexer.index(self)
    end

    def remove_index
    end

    def bucket_name
    end

    def indexes_as
      Hash.new

      # index_data = { :id => queryable_obj.key }

      # queryable_obj.class.query_fields.each do |field|
      #   index_data.merge field.indexes_as(queryable_obj)
      # end
    end

    class << self
      def included(base)
        base.module_eval do
          extend ActsAsMethods
        end
      end
    end

    module ActsAsMethods
      def queryable(&block)

      end
    end
  end
end
