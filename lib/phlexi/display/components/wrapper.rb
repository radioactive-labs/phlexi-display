# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Wrapper < Base
        def view_template
          div(**attributes) {
            render field.label_tag
            yield field if block_given?
            render field.description_tag
          }
        end
      end
    end
  end
end
