class NullObject
 def initialize
    @origin = caller.first ### SETS ORIGIN FOR INSPECT INFO
  end

  def method_missing(*args, &block)
    self
  end

  def nil?; true; end
end


def Maybe(value)
  if value.nil? then
    block_given? ? yield : NullObject.new
  else
    value
  end
end
