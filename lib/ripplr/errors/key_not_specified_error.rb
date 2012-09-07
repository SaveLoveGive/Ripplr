require 'ripplr/translation'

class Ripplr::KeyNotSpecifiedError
  include Ripplr::Translation

  def exception(message=t("key_not_specified"))
    RuntimeError.new message
  end
end
