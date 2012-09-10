module Ripplr
  class QueryField
    def initialize(type, property_name)
      @type = type
      @property_name = property_name
    end

    def indexes_as(queryable_object)
      return { index_name => queryable_object.send(@property_name) }
    end

    def for?(property_name)
      @property_name == property_name
    end

    def index_name
      "#{@property_name.to_s}_#{@type.to_s}".to_sym
    end
  end
end
