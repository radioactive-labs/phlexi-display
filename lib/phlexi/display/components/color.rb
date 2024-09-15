# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Color < Base
        include Concerns::DisplaysValue

        def render_value(value)
          div(**attributes) {
            div(class: themed(:color_indicator), style: "background-color: #{value};") {
              whitespace
            }
            p { value }
          }
        end
      end
    end
  end
end
