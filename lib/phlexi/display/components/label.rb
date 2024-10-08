# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Label < Base
        def view_template
          h5(**attributes) {
            field.label
          }
        end
      end
    end
  end
end
