# frozen_string_literal: true

require "bigdecimal"

module Phlexi
  module Display
    module FieldOptions
      module InferredTypes
        def inferred_db_type
          @inferred_db_type ||= infer_db_type
        end

        def inferred_display_component
          @inferred_display_component ||= infer_display_component
        end

        private

        def infer_display_component
          case inferred_db_type
          when :string, :text
            infer_string_display_type(key)
          when :integer, :float, :decimal
            :number
          when :date, :datetime, :time
            :date
          when :boolean
            :boolean
          when :json, :jsonb, :hstore
            :code
          else
            if association_reflection
              :association
            elsif attachment_reflection
              :attachment
            else
              :text
            end
          end
        end

        def infer_db_type
          if object.class.respond_to?(:columns_hash)
            # ActiveRecord object
            column = object.class.columns_hash[key.to_s]
            return column.type if column
          end

          if object.class.respond_to?(:attribute_types)
            # ActiveModel::Attributes
            custom_type = object.class.attribute_types[key.to_s]
            return custom_type.type if custom_type
          end

          # Check if object responds to the key
          if object.respond_to?(key)
            # Fallback to inferring type from the value
            return infer_db_type_from_value(object.send(key))
          end

          # Default to string if we can't determine the type
          :string
        end

        def infer_db_type_from_value(value)
          case value
          when Integer
            :integer
          when Float
            :float
          when BigDecimal
            :decimal
          when TrueClass, FalseClass
            :boolean
          when Date
            :date
          when Time, DateTime
            :datetime
          when Hash
            :json
          else
            :string
          end
        end

        def infer_string_display_type(key)
          key = key.to_s.downcase

          return :password if is_password_field?

          custom_type = custom_string_display_type(key)
          return custom_type if custom_type

          :text
        end

        def custom_string_display_type(key)
          custom_mappings = {
            /url$|^link|^site/ => :url,
            /^email/ => :email,
            /phone|tel(ephone)?/ => :phone,
            /^time/ => :time,
            /^date/ => :date,
            /^number|_count$|_amount$/ => :number,
            /^color/ => :color
          }

          custom_mappings.each do |pattern, type|
            return type if key.match?(pattern)
          end

          nil
        end

        def is_password_field?
          key = self.key.to_s.downcase

          exact_matches = ["password"]
          prefixes = ["encrypted_"]
          suffixes = ["_password", "_digest", "_hash"]

          exact_matches.include?(key) ||
            prefixes.any? { |prefix| key.start_with?(prefix) } ||
            suffixes.any? { |suffix| key.end_with?(suffix) }
        end
      end
    end
  end
end
