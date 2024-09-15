# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Enum < Base
        include Concerns::DisplaysValue

        def render_value(value)
          p(**attributes) {
            value
          }
        end
      end
    end
  end
end
