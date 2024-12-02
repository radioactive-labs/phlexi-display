# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Phone < Base
        include Concerns::DisplaysValue

        def render_value(value)
          a(**attributes, href: "tel:#{value}", target: "_blank") {
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
              d: "M5 4h4l2 5l-2.5 1.5a11 11 0 0 0 5 5l1.5 -2.5l5 2v4a2 2 0 0 1 -2 2a16 16 0 0 1 -15 -15a2 2 0 0 1 2 -2"
            )
          end
        end
      end
    end
  end
end
