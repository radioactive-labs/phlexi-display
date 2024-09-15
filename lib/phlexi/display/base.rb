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
    class Base < Phlexi::Display::HTML
      class Namespace < Phlexi::Field::Structure::Namespace; end

      class Builder < Phlexi::Display::Builder; end

      def self.inline(*, **, &block)
        raise ArgumentError, "block is required" unless block

        new(*, **) do |f|
          f.instance_exec(&block)
        end
      end

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
        @attributes = attributes
        @namespace_klass = options.delete(:namespace_klass) || self.class::Namespace
        @builder_klass = options.delete(:builder_klass) || self.class::Builder
        @options = options

        initialize_object_and_key(record)
        initialize_namespace
      end

      # Renders the display template.
      #
      # @return [void]
      def view_template(&)
        display_wrapper { display_template(&) }
      end

      # Executes the display's content block.
      # Override this in subclasses to define a static display.
      #
      # @return [void]
      def display_template
        yield if block_given?
      end

      protected

      attr_reader :options, :attributes, :namespace_klass, :builder_klass

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
          if @key.nil?
            @key = if object.respond_to?(:model_name) && object.model_name.respond_to?(:param_key) && object.model_name.param_key.present?
              object.model_name.param_key
            else
              object.class.name.demodulize.underscore
            end
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
      def display_class
        themed(:base)
      end

      # Generates the display attributes hash.
      #
      # @return [Hash] The display attributes
      def display_attributes
        mix({
          id: @namespace.dom_id,
          class: display_class
        }, attributes)
      end

      def display_wrapper(&)
        div(**display_attributes) do
          yield
        end
      end
    end
  end
end
