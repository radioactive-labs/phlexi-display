# frozen_string_literal: true

module Phlexi
  module Display
    module Structure
      class FieldCollection
        include Enumerable

        class Builder
          attr_reader :key, :index

          def initialize(key, field, index)
            @key = key.to_s
            @field = field
            @index = index
          end

          def field(**)
            @field.class.new(key, **, parent: @field).tap do |field|
              yield field if block_given?
            end
          end
        end

        def initialize(field:, collection:, &)
          @field = field
          @collection = collection
          each(&) if block_given?
        end

        def each(&)
          @collection.each.with_index do |item, index|
            yield Builder.new(item, @field, index)
          end
        end
      end
    end
  end
end
