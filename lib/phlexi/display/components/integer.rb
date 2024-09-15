# frozen_string_literal: true

require "active_support/number_helper"

module Phlexi
  module Display
    module Components
      class Integer < Number
        private

        def normalize_value(value)
          value.to_i
        end
      end
    end
  end
end
