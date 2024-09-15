# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Password < Base
        include Concerns::DisplaysValue

        def render_value(value)
          p(**attributes) {
            value
          }
        end

        protected

        def normalize_value(value)
          "••••••••"
        end
      end
    end
  end
end
