module Phlexi
  module Display
    class HTML < (defined?(::ApplicationComponent) ? ::ApplicationComponent : Phlex::HTML)
      module Behaviour
        protected

        def themed(component)
          Phlexi::Display::Theme.instance.resolve_theme(component)
        end
      end

      include Behaviour
      include Phlexi::Field::Common::Tokens
    end
  end
end
