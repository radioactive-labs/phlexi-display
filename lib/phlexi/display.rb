# frozen_string_literal: true

require "zeitwerk"
require "phlex"
require "active_support/core_ext/object/blank"

module Phlexi
  module Display
    Loader = Zeitwerk::Loader.new.tap do |loader|
      loader.tag = File.basename(__FILE__, ".rb")
      loader.inflector.inflect(
        "phlexi-display" => "Phlexi",
        "phlexi" => "Phlexi",
        "dom" => "DOM"
      )
      loader.push_dir(File.expand_path("..", __dir__))
      loader.setup
    end

    COMPONENT_BASE = (defined?(::ApplicationComponent) ? ::ApplicationComponent : Phlex::HTML)

    NIL_VALUE = :__i_phlexi_display_nil_value_i__

    class Error < StandardError; end
  end
end

def Phlexi.Display(...)
  Phlexi::Display::Base.new(...)
end
