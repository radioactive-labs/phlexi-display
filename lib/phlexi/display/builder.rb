# frozen_string_literal: true

require "phlex"

module Phlexi
  module Display
    # Builder class is responsible for building display fields with various options and components.
    class Builder < Phlexi::Field::Builder
      include Phlexi::Display::Options::InferredTypes

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
      alias_method :search_tag, :string_tag

      def text_tag(**, &)
        create_component(Components::String, :text, **, &)
      end

      def phone_tag(**, &)
        create_component(Components::String, :phone, **, &)
      end

      # Creates a number display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the number display.
      # @return [Components::Number] The number component.
      def number_tag(**, &)
        create_component(Components::Number, :number, **, &)
      end

      def integer_tag(**, &)
        create_component(Components::Integer, :integer, **, &)
      end

      def json_tag(**, &)
        create_component(Components::JSON, :json, **, &)
      end

      def hstore_tag(**, &)
        create_component(Components::JSON, :hstore, **, &)
      end

      # Creates a datetime display for the field.
      #
      # @param attributes [Hash] Additional attributes for the datetime display.
      # @return [Components::DateTime] The datetime component.
      def datetime_tag(**, &)
        create_component(Components::DateTime, :datetime, **, &)
      end

      def date_tag(**, &)
        create_component(Components::DateTime, :date, **, &)
      end

      def time_tag(**, &)
        create_component(Components::Time, :time, **, &)
      end

      # # Creates a boolean display tag for the field.
      # #
      # # @param attributes [Hash] Additional attributes for the boolean display.
      # # @return [Components::Boolean] The boolean component.
      # def boolean_tag(**, &)
      #   create_component(Components::Boolean, :boolean, **, &)
      # end

      # Creates a color display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the color display.
      # @return [Components::Color] The color component.
      def color_tag(**, &)
        create_component(Components::Color, :color, **, &)
      end

      # Creates a password display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the password display.
      # @return [Components::Password] The password component.
      def password_tag(**, &)
        create_component(Components::Password, :password, **, &)
      end

      # Creates a enum display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the enum display.
      # @return [Components::Enum] The enum component.
      def enum_tag(**, &)
        create_component(Components::Enum, :enum, **, &)
      end

      # Creates a email display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the email display.
      # @return [Components::Email] The email component.
      def email_tag(**, &)
        create_component(Components::Email, :email, **, &)
      end

      # Creates a url display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the url display.
      # @return [Components::Url] The url component.
      def url_tag(**, &)
        create_component(Components::Url, :url, **, &)
      end

      # Creates an association display tag for the field.
      #
      # @param attributes [Hash] Additional attributes for the association display.
      # @return [Components::Association] The association component.
      def association_tag(**, &)
        create_component(Components::Association, :association, **, &)
      end

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
