# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      module Concerns
        module DisplaysValue
          def view_template
            value = normalize_value(field.value)
            if value.blank?
              render field.placeholder_tag(**@placeholder_attributes)
            else
              render_value(value)
            end
          end

          # Renders the field value for display.
          #
          # @return [String] the formatted field value for display.
          def render_value(value)
            raise NotImplementedError, "#{self.class}#render_value"
            # format_value()
          end

          protected

          def build_attributes
            super

            @placeholder_attributes = attributes.delete(:placeholder_attributes) || {}
            attributes[:id] = field.dom.id if attributes[:id] == "#{field.dom.id}_#{component_name}"
          end

          # def format_value(value)
          #   case value
          #   when Array
          #     format_array_value(value)
          #   else
          #     format_single_value(value)
          #   end
          # end

          # def format_array_value(array)
          #   array.map { |item| format_single_value(item) }.join(", ")
          # end

          def normalize_value(value)
            value.to_s
          end
        end
      end
    end
  end
end
