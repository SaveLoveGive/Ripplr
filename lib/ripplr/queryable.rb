module Ripplr
  module Queryable
    def index(indexer=Ripplr::Indexers::Ripple)
      indexer.index self
    end

    def remove_index(indexer=Ripple.client)
    end

    def bucket_name
      self.class.bucket.name
    end

    def indexes_as
      index_data = { :id => self.key }

      self.class.query_fields.each do |field|
        index_data.merge! field.indexes_as(self)
      end
      index_data
    end

    class << self
      def included(base)
        base.module_eval do
          extend QueryableClassMethods
        end
      end
    end

    module QueryableClassMethods
      def search(property, query, indices=Ripplr::Indexers::Ripple)
        indices.search self, "#{queryable_field(property)}: \"#{query}\""
      end

      def count
        self.bucket.list.size
      end

      def query_fields
        @query_fields ||= Array.new
        @query_fields
      end

      def queryable(&block)
        block.call
      end

      def time(*names)
        names.each do |name|
          query_fields << Ripplr::QueryField.new(:dt, name)
        end
      end

      def text(*names)
        names.each do |name|
          query_fields << Ripplr::QueryField.new(:text, name)
        end
      end

      protected
      def queryable_field(property_name)
        matches = query_fields.select{|f| f.for? property_name}
        raise Ripplr::FieldNotQueryableError.new(property_name) if matches.empty?

        matches.first.index_name
      end
    end
  end
end
