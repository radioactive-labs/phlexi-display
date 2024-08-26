# frozen_string_literal: true

module Phlexi
  module Display
    module Structure
      # Generates DOM IDs for a Field, Namespace, or Node based on
      # norms that were established by Rails. These can be used outside of Rails in
      # other Ruby web frameworks since it has no dependencies on Rails.
      class DOM
        def initialize(field:)
          @field = field
        end

        # Converts the value of the field to a String, which is required to work
        # with Phlex. Assumes that `Object#to_s` emits a format suitable for display.
        def value
          @field.value.to_s
        end

        # Walks from the current node to the parent node, grabs the names, and separates
        # them with a `_` for a DOM ID.
        def id
          @id ||= begin
            root, *rest = lineage
            root_key = root.respond_to?(:dom_id) ? root.dom_id : root.key
            rest.map(&:key).unshift(root_key).join("_")
          end
        end

        # One-liner way of walking from the current node all the way up to the parent.
        def lineage
          @lineage ||= Enumerator.produce(@field, &:parent).take_while(&:itself).reverse
        end

        # Emit the id and value in an HTML tag-ish that doesn't have an element.
        def inspect
          "<#{self.class.name} id=#{id.inspect} value=#{value.inspect}/>"
        end
      end
    end
  end
end
