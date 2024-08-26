# frozen_string_literal: true

module Phlexi
  module Display
    module FieldOptions
      module Themes
        # Resolves theme classes for components based on their type.
        #
        # This method is responsible for determining the appropriate CSS classes for a given display component.
        # It supports a hierarchical theming system, allowing for cascading themes and easy customization.
        #
        # @param component [Symbol, String] The type of display component (e.g., :text, :date, :boolean)
        #
        # @return [String, nil] A string of CSS classes for the component, or nil if no theme is applied
        #
        # @example Basic usage
        #   themed(:text)
        #   # => "text-gray-700 text-sm"
        #
        # @example Cascading themes
        #   # Assuming email inherits from text in the theme definition
        #   themed(:email)
        #   # => "text-gray-700 text-sm text-blue-600 underline"
        #
        # @note The actual CSS classes returned will depend on the theme definitions in the `theme` hash
        #       and any overrides specified in the `options` hash.
        #
        # @see #resolve_theme
        # @see #theme
        def themed(component)
          return unless component

          resolve_theme(component)
        end

        protected

        # Recursively resolves the theme for a given property, handling nested symbol references
        #
        # @param property [Symbol, String] The theme property to resolve
        # @param visited [Set] Set of already visited properties to prevent infinite recursion
        # @return [String, nil] The resolved theme value or nil if not found
        #
        # @example Resolving a nested theme
        #   # Assuming the theme is: { email: :text, text: "text-gray-700" }
        #   resolve_theme(:email)
        #   # => "text-gray-700"
        def resolve_theme(property, visited = Set.new)
          return nil if !property.present? || visited.include?(property)
          visited.add(property)

          result = theme[property]
          if result.is_a?(Symbol)
            resolve_theme(result, visited)
          else
            result
          end
        end

        # Retrieves or initializes the theme hash for the display builder.
        #
        # This method returns a hash containing theme definitions for various display components.
        # If a theme has been explicitly set in the options, it returns that. Otherwise, it
        # initializes and returns a default theme.
        #
        # The theme hash defines CSS classes or references to other theme keys for different
        # components.
        #
        # @return [Hash] A hash containing theme definitions for display components
        #
        # @example Accessing the theme
        #   theme[:text]
        #   # => "text-gray-700 text-sm"
        #
        # @example Theme inheritance
        #   theme[:email] # Returns :text, indicating email inherits text's theme
        #
        # @note The actual content of the theme hash depends on the default_theme method
        #       and any theme overrides specified in the options when initializing the field builder.
        #
        # @see #default_theme
        def theme
          @theme ||= options[:theme] || default_theme
        end

        # Defines and returns the default theme hash for the display builder.
        #
        # This method returns a hash containing the base theme definitions for various components.
        # It sets up the default styling and relationships between different components.
        # The theme uses a combination of explicit CSS classes and symbolic references to other theme keys,
        # allowing for a flexible and inheritance-based theming system.
        #
        # @return [Hash] A frozen hash containing default theme definitions for components
        #
        # @example Accessing the default theme
        #   default_theme[:text]
        #   # => "text-gray-700 text-sm"
        #
        # @example Theme inheritance
        #   default_theme[:email]
        #   # => :text (indicates that :email inherits from :text)
        #
        # @note This method returns a frozen hash to prevent accidental modifications.
        #       To customize the theme, users should provide their own theme hash when initializing the display builder.
        #
        # @see #theme
        def default_theme
          {
            label: "text-base font-bold text-gray-500 dark:text-gray-400 mb-1",
            description: "text-sm text-gray-400 dark:text-gray-500",
            placeholder: "text-xl font-semibold text-gray-500 dark:text-gray-300 mb-1 italic",
            string: "text-xl font-semibold text-gray-900 dark:text-white mb-1",
            # text: :string,
            number: :string,
            datetime: :string,
            # boolean: :string,
            # code: :string,
            # email: :text,
            # url: :text,
            # phone: :text,
            # color: :text,
            # search: :text,
            # password: :string,
            # association: :string,
            attachment: :string,
            wrapper: nil
          }.freeze
        end
      end
    end
  end
end
