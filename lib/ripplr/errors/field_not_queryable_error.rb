require 'ripplr/translation'

class Ripplr::FieldNotQueryableError
  include Ripplr::Translation

  def initialize(field_name)
    @field_name = field_name
  end

  def exception(message=t("errors.field_not_queryable", :field => @field_name))
    RuntimeError.new message
  end
end
