# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Email < Base
        include Concerns::DisplaysValue

        def render_value(value)
          a(**attributes, href: "mailto:#{value}", target: "_blank") {
            icon
            plain value
          }
        end

        protected

        def icon
          icon_theme = themed(:prefixed_icon)
          svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: icon_theme ? nil : "24",
            height: icon_theme ? nil : "24",
            class: icon_theme,
            viewbox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round"
          ) do |s|
            s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
            s.path(
              d:
                "M3 7a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v10a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-10z"
            )
            s.path(d: "M3 7l9 6l9 -6")
          end
        end
      end
    end
  end
end
