# frozen_string_literal: true

module Phlexi
  module Display
    module FieldOptions
      module Description
        def description(description = nil)
          if description.nil?
            options[:description]
          else
            options[:description] = description
            self
          end
        end

        def has_description?
          description.present?
        end
      end
    end
  end
end
