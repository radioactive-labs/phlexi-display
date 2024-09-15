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
          p(**attributes) { value }
        end

        protected

        def build_attributes
          super

          @options = attributes.delete(:options) || {}
          @formats = Array(@options.delete(:format)).compact + default_formats
        end

        def format_value(value)
          @formats.each do |fmt|
            return I18n.l(value, **@options, format: fmt)
          rescue
            nil
          end
        end

        def default_formats
          [:long]
        end

        def normalize_value(value)
          case value
          when ::DateTime, ::Date, ::Time
            format_value(value)
          else
            value.to_s
          end
        end
      end
    end
  end
end
