# frozen_string_literal: true

require "zeitwerk"
require "phlex"
require "phlexi-field"
require "active_support/core_ext/object/blank"

module Phlexi
  module Display
    Loader = Zeitwerk::Loader.new.tap do |loader|
      loader.tag = File.basename(__FILE__, ".rb")
      loader.inflector.inflect(
        "phlexi-display" => "Phlexi",
        "phlexi" => "Phlexi",
        "html" => "HTML",
        "json" => "JSON"
      )
      loader.push_dir(File.expand_path("..", __dir__))
      loader.setup
    end

    class Error < StandardError; end
  end
end

def Phlexi.Display(...)
  Phlexi::Display::Base.inline(...)
end
