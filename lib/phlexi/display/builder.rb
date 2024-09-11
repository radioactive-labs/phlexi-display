# frozen_string_literal: true

require "phlex"

module Phlexi
  module Display
    # Builder class is responsible for building display fields with various options and components.
    #
    # @attr_reader [Structure::DOM] dom The DOM structure for the field.
    # @attr_reader [Hash] options Options for the field.
    # @attr_reader [Object] object The object associated with the field.
    # @attr_reader [Hash] attributes Attributes for the field.
    # @attr_accessor [Object] value The value of the field.
    class Builder < Phlexi::Field::Builder
      # Creates a label tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the label.
      # @return [Components::Label] The label component.
      def label_tag(**, &)
        create_component(Components::Label, :label, **, &)
      end

      # Creates a Placeholder tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the placeholder.
      # @return [Components::Placeholder] The placeholder component.
      def placeholder_tag(**, &)
        create_component(Components::Placeholder, :placeholder, **, &)
      end

      # Creates a Description tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the description.
      # @return [Components::Description] The description component.
      def description_tag(**, &)
        create_component(Components::Description, :description, **, &)
      end

      # Creates a string display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the string display.
      # @return [Components::String] The string component.
      def string_tag(**, &)
        create_component(Components::String, :string, **, &)
      end

      # # Creates a text display tag for the field.
      # #
      # # @param attributes [Hash] Additional attributes for the text display.
      # # @return [Components::Text] The text component.
      # def text_tag(**, &)
      #   create_component(Components::Text, :text, **, &)
      # end

      # Creates a number display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the number display.
      # @return [Components::Number] The number component.
      def number_tag(**, &)
        create_component(Components::Number, :number, **, &)
      end

      # Creates a datetime display for the field.
      #
      # @param attributes [Hash] Additional attributes for the datetime display.
      # @return [Components::DateTime] The datetime component.
      def datetime_tag(**, &)
        create_component(Components::DateTime, :datetime, **, &)
      end

      # # Creates a boolean display tag for the field.
      # #
      # # @param attributes [Hash] Additional attributes for the boolean display.
      # # @return [Components::Boolean] The boolean component.
      # def boolean_tag(**, &)
      #   create_component(Components::Boolean, :boolean, **, &)
      # end

      # # Creates an association display tag for the field.
      # #
      # # @param attributes [Hash] Additional attributes for the association display.
      # # @return [Components::Association] The association component.
      # def association_tag(**, &)
      #   create_component(Components::Association, :association, **, &)
      # end

      # # Creates an attachment display tag for the field.
      # #
      # # @param attributes [Hash] Additional attributes for the attachment display.
      # # @return [Components::Attachment] The attachment component.
      # def attachment_tag(**, &)
      #   create_component(Components::Attachment, :attachment, **, &)
      # end

      # Wraps the field with additional markup.
      #
      # @param attributes [Hash] Additional attributes for the wrapper.
      # @yield [block] The block to be executed within the wrapper.
      # @return [Components::Wrapper] The wrapper component.
      def wrapped(**, &)
        create_component(Components::Wrapper, :wrapper, **, &)
      end

      protected

      def create_component(component_class, theme_key, **attributes, &)
        theme_key = attributes.delete(:theme) || theme_key
        attributes = mix({class: themed(theme_key)}, attributes) unless attributes.key?(:class!)
        component_class.new(self, **attributes, &)
      end

      def themed(component)
        Phlexi::Display::Theme.instance.resolve_theme(component)
      end
    end
  end
end