# frozen_string_literal: true

require "active_support/number_helper"

module Phlexi
  module Display
    module Components
      class Number < Base
        include Concerns::DisplaysValue

        def render_value(value)
          p(**attributes) {
            format_number(value)
          }
        end

        protected

        def build_attributes
          super

          @options = attributes.delete(:options) || {}
        end

        private

        def format_number(value)
          ActiveSupport::NumberHelper.number_to_delimited(value, **@options)
        end

        def normalize_value(value)
          Float(value.to_s)
        end
      end
    end
  end
end
