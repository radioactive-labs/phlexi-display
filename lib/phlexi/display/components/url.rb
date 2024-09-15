# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Url < Base
        include Concerns::DisplaysValue

        def render_value(value)
          a(**attributes, href: value, target: "_blank") {
            icon
            plain value
          }
        end

        protected

        def icon
          icon_theme = themed(:prefixed_icon)
          svg(
            xmlns: "http://www.w3.org/2000/svg",
            width: icon_theme || "24",
            height: icon_theme || "24",
            class: icon_theme,
            viewbox: "0 0 24 24",
            fill: "none",
            stroke: "currentColor",
            stroke_width: "2",
            stroke_linecap: "round",
            stroke_linejoin: "round"
          ) do |s|
            s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
            s.path(d: "M9 15l6 -6")
            s.path(d: "M11 6l.463 -.536a5 5 0 0 1 7.071 7.072l-.534 .464")
            s.path(
              d:
                "M13 18l-.397 .534a5.068 5.068 0 0 1 -7.127 0a4.972 4.972 0 0 1 0 -7.071l.524 -.463"
            )
          end
        end
      end
    end
  end
end
