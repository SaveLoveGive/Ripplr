module Ripplr
  class Criteria

    def initialize(klass, indexer=Ripplr::Indexers::Ripple)
      @indexer = indexer
      @target = klass
    end

    def where(condition)
      self.condition = condition
      self
    end

    def order_by(field)
      @order_by_field = @target.queryable_field(field)
      self
    end

    def ascending
      @order_by_direction = " asc"
      self
    end

    def descending
      @order_by_direction = " desc"
      self
    end

    def [](index)
      results[index]
    end

    def each(&block)
      results.each do |result|
        yield result
      end
    end

    def size
      results.size
    end
    alias :length :size
    alias :count :size

    def to_a
      results
    end

    def execute
      return @target.list if condition.nil?

      @indexer.search @target, query, options
    end

    def conditions
      condition
    end

    private
    def results
      @results ||= execute
      @results
    end

    def options
      Maybe(ordering) { Hash.new }
    end

    def ordering
      return NullObject.new if @order_by_field.nil?
      sort = { :sort => "#{@order_by_field.to_s}" }
      sort[:sort] += @order_by_direction unless @order_by_direction.nil?
      sort
    end

    def condition
      @condition
    end

    def condition=(value)
      @condition = { @target.queryable_field(value.keys.first) => value.values.first }
    end

    def query
      "#{condition.keys.first}: \"#{condition.values.first}\""
    end

  end
end
