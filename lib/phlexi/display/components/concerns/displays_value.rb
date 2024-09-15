# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      module Concerns
        module DisplaysValue
          def view_template
            return render(field.placeholder_tag(**@placeholder_attributes)) unless field.has_value?

            values = (field.multiple? && field.value.respond_to?(:each)) ? field.value : [field.value]
            values.each do |value|
              render_value(normalize_value(value))
            end
          end

          # Renders the field value for display.
          #
          # @return [String] the formatted field value for display.
          def render_value(value)
            raise NotImplementedError, "#{self.class}#render_value"
          end

          protected

          def build_attributes
            super

            @placeholder_attributes = attributes.delete(:placeholder_attributes) || {}
            attributes[:id] = field.dom.id if attributes[:id] == "#{field.dom.id}_#{component_name}"
          end

          def normalize_value(value)
            value.to_s
          end
        end
      end
    end
  end
end
