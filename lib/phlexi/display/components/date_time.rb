# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class DateTime < Base
        include Concerns::DisplaysValue

        # Renders the date time value
        #
        # @param value [String, Date, Time, DateTime] The value to be rendered
        # @return [void]
        def render_value(value)
          formatted_value = format_date_time(value)
          p(**attributes) { formatted_value }
        end

        protected

        def build_attributes
          super

          @options = {
            format: default_format
          }.merge(attributes.delete(:options) || {}).compact
        end

        private

        def format_date_time(value)
          I18n.l(value, **@options)
        end

        def default_format
          :long
        end

        def normalize_value(value)
          case value
          when Date, DateTime, Time, nil
            value
          else
            raise ArgumentError, "Value must be a Date, DateTime or Time object. #{value.inspect} given."
          end
        end
      end
    end
  end
end
