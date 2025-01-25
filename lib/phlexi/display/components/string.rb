# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class String < Base
        include Concerns::DisplaysValue

        def render_value(value)
          p(**attributes) {
            maybe_format_value value
          }
        end

        protected

        def build_attributes
          super
          @formatter = attributes[:formatter]
        end

        def maybe_format_value(value)
          return value unless @formatter

          @formatter.call(value)
        end
      end
    end
  end
end
