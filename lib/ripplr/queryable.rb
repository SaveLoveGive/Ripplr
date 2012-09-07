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
