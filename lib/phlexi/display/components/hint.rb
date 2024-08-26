# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Hint < Base
        def view_template
          p(**attributes) do
            field.hint
          end
        end

        private

        def render?
          field.has_hint?
        end
      end
    end
  end
end
