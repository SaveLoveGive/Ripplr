require 'ripplr/i18n'
require 'riak/util/translation'

module Ripplr
  module Translation
    include Riak::Util::Translation

    # The scope of i18n keys to search (:ripple).
    def i18n_scope
      :ripplr
    end
  end

  # A dummy object so translations can be accessed without module
  # inclusion.
  Translator = Object.new.tap {|o| o.extend Translation }
end
