# frozen_string_literal: true

module Phlexi
  module Display
    module Options
      module InferredTypes
        private

        def infer_field_component
          case inferred_field_type
          when :string, :text
            infer_string_field_type || inferred_field_type
          when :float, :decimal
            :number
          when :json, :jsonb
            :json
          # when :attachment, :binary
          #   :attachment
          # end
          when :integer, :association, :hstore, :date, :time, :datetime
            inferred_field_type
          else
            :string
          end
        end
      end
    end
  end
end
