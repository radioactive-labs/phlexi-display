# frozen_string_literal: true

module Phlexi
  module Display
    module FieldOptions
      module Attachments
        protected

        def attachment_reflection
          @attachment_reflection ||= find_attachment_reflection
        end

        def find_attachment_reflection
          if object.class.respond_to?(:reflect_on_attachment)
            object.class.reflect_on_attachment(key)
          end
        end
      end
    end
  end
end
