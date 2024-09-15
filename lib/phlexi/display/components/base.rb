# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Base < Phlexi::Field::Components::Base
        include Phlexi::Display::HTML::Behaviour
      end
    end
  end
end
