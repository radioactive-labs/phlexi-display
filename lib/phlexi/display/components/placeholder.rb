# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Placeholder < Base
        def view_template
          p(**attributes) {
            field.placeholder
          }
        end
      end
    end
  end
end
