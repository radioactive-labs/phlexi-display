# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Time < DateTime
        protected

        def default_formats
          [:time, "%H:%M"]
        end
      end
    end
  end
end
