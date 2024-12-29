# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      module Concerns
        module DisplaysValue
          def view_template
            return render(field.placeholder_tag(**@placeholder_attributes)) unless field.has_value?

            if field.multiple? && field.value.respond_to?(:each)
              wrapped {
                field.value.each { |value|
                  value = normalize_value(value)
                  render_value(value)
                }
              }
            else
              wrapped {
                value = normalize_value(field.value)
                render_value(value)
              }
            end
          end

          def wrapped(&)
            div(
              id: attributes.delete(:id),
              class: tokens(component_name, "value_wrapper", themed(:value_wrapper), themed(:"#{component_name}_value_wrapper")),
              &
            )
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

          def build_component_class
            return if attributes[:class] == false

            super
            attributes[:class] = tokens(component_name, "value", attributes[:class].sub(component_name, ""))
          end

          def normalize_value(value)
            value.to_s
          end
        end
      end
    end
  end
end
