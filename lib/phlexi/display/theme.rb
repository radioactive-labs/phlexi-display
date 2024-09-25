module Phlexi
  module Display
    class Theme < Phlexi::Field::Theme
      def self.theme
        @theme ||= {
          base: nil,
          label: nil,
          description: nil,
          placeholder: nil,
          value_wrapper: nil,
          string: nil,
          text: :string,
          phone: :string,
          number: :string,
          integer: :string,
          datetime: :string,
          date: :datetime,
          time: :datetime,
          association: :string,
          attachment: :string,
          color: :string,
          color_icon: :string,
          email: :string,
          url: :email,
          json: :string,
          hstore: :json,
          password: :string,
          enum: :string,
          prefixed_icon: nil,
          link: nil,
          wrapper: nil
        }.freeze
      end
    end
  end
end
