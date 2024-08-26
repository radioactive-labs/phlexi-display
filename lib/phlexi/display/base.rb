# frozen_string_literal: true

require "active_support/core_ext/module/delegation"
require "active_support/core_ext/string/inflections"

module Phlexi
  module Display
    # A display component for rendering flexible and customizable data views.
    #
    # @example Basic usage
    #   Phlexi::Display.new(user) do |d|
    #     render d.field(:name).text
    #     render d.field(:email).text
    #   end
    #
    # @attr_reader [Symbol] key The display's key, derived from the record or explicitly set
    # @attr_reader [ActiveModel::Model, nil] object The display's associated object
    class Base < COMPONENT_BASE
      class Namespace < Structure::Namespace; end

      class FieldBuilder < Structure::FieldBuilder; end

      attr_reader :key, :object

      delegate :field, :nest_one, :nest_many, to: :@namespace

      # Initializes a new Display instance.
      #
      # @param record [ActiveModel::Model, Symbol, String] The display's associated record or key
      # @param attributes [Hash] Additional HTML attributes for the display container
      # @param options [Hash] Additional options for display configuration
      # @option options [String] :class CSS classes for the display
      # @option options [Class] :namespace_klass Custom namespace class
      # @option options [Class] :builder_klass Custom field builder class
      def initialize(record, attributes: {}, **options)
        @display_class = options.delete(:class)
        @attributes = attributes
        @namespace_klass = options.delete(:namespace_klass) || default_namespace_klass
        @builder_klass = options.delete(:builder_klass) || default_builder_klass
        @options = options

        initialize_object_and_key(record)
        initialize_namespace
      end

      # Renders the display template.
      #
      # @return [void]
      def view_template
        display_template
      end

      protected

      attr_reader :options, :attributes, :namespace_klass, :builder_klass

      # Executes the display's content block.
      # Override this in subclasses to define a static display.
      #
      # @return [void]
      def display_template
        instance_exec(&@_content_block) if @_content_block
      end

      # Initializes the object and key based on the given record.
      #
      # @param record [ActiveModel::Model, Symbol, String] The display's associated record or key
      # @return [void]
      def initialize_object_and_key(record)
        @key = options.delete(:key) || options.delete(:as)

        case record
        when String, Symbol
          @object = nil
          @key = record
        else
          @object = record
          @key = if @key.nil? && object.respond_to?(:model_name) && object.model_name.respond_to?(:param_key) && object.model_name.param_key.present?
            object.model_name.param_key
          else
            :object
          end
        end
        @key = @key.to_sym
      end

      # Initializes the namespace for the display.
      #
      # @return [void]
      def initialize_namespace
        @namespace = namespace_klass.root(key, object: object, builder_klass: builder_klass)
      end
      # Retrieves the display's CSS classes.
      #
      # @return [String] The display's CSS classes
      attr_reader :display_class

      # Generates the display attributes hash.
      #
      # @return [Hash] The display attributes
      def display_attributes
        {
          id: @namespace.dom_id,
          class: display_class,
          **attributes
        }
      end

      private

      def default_namespace_klass
        self.class::Namespace
      end

      def default_builder_klass
        self.class::FieldBuilder
      end
    end
  end
end
