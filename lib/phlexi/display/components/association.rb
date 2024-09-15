# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Association < Base
        include Concerns::DisplaysValue

        def render_value(value)
          p(**attributes) {
            display_name_of(value)
          }
        end

        protected

        def display_name_of(obj, separator: ", ")
          return unless obj.present?

          # Retrieve the value from a predefined list
          %i[to_label name title].each do |method|
            name = obj.public_send(method) if obj.respond_to?(method)
            return name if name.present?
          end

          # Maybe this is a record?
          if (primary_key = Phlexi::Field.object_primary_key(obj))
            return "#{obj.class.model_name.human} ##{primary_key}"
          end

          # Oh well. Just convert it to a string.
          obj.to_s
        end

        def normalize_value(value)
          value
        end
      end
    end
  end
end
