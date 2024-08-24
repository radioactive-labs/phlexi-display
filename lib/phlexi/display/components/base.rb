# frozen_string_literal: true

module Phlexi
  module Display
    module Components
      class Base < COMPONENT_BASE
        attr_reader :field, :attributes

        def initialize(field, **attributes)
          @field = field
          @attributes = attributes

          build_attributes
          append_attribute_classes
        end

        protected

        def build_attributes
          attributes.fetch(:id) { attributes[:id] = "#{field.dom.id}_#{component_name}" }
        end

        def append_attribute_classes
          return if attributes[:class] == false

          attributes[:class] = tokens(
            component_name,
            attributes[:class],
            -> { attributes[:required] } => "required",
            -> { !attributes[:required] } => "optional",
            -> { field.has_errors? } => "invalid",
            -> { attributes[:readonly] } => "readonly",
            -> { attributes[:disabled] } => "disabled"
          )
        end

        def component_name
          @component_name ||= self.class.name.demodulize.underscore
        end
      end
    end
  end
end



User
 name: :string
 validate :name, presence: true

f.input :name