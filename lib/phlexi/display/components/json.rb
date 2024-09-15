# frozen_string_literal: true

require "json"

module Phlexi
  module Display
    module Components
      class JSON < Base
        include Concerns::DisplaysValue

        def render_value(value)
          pre(**attributes) {
            value
          }
        end

        private

        def normalize_value(value)
          ::JSON.pretty_generate(value)
        end
      end
    end
  end
end
