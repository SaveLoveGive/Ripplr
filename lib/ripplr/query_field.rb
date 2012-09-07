module Ripplr
  class QueryField
    def initialize(type, property_name)
      @type = type
      @property = property_name
    end

    def indexes_as(queryable_object)
      return { index_name(@type, @property) => queryable_object.send(@property) }
    end

    private
    def index_name(type, property_name)
      "#{property_name.to_s}_#{type.to_s}".to_sym
    end
  end
end
