# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Description < Base
        def view_template
          p(**attributes) {
            field.description
          }
        end

        private

        def render?
          field.has_description?
        end
      end
    end
  end
end
