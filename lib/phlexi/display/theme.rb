module Phlexi
  module Display
    class Theme
      include Phlexi::Field::Theme

      DEFAULT_THEME = {
        label: nil,
        description: nil,
        placeholder: nil,
        string: nil,
        number: :string,
        datetime: :string,
        attachment: :string,
        wrapper: nil
      }.freeze

      def theme
        DEFAULT_THEME
      end
    end
  end
end
