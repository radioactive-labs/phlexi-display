# frozen_string_literal: true

module Phlexi
  module Display
    module Structure
      # A Namespace maps an object to values, but doesn't actually have a value itself. For
      # example, a `User` object or ActiveRecord model could be passed into the `:user` namespace.
      #
      # To access single values on a Namespace, #field can be used.
      #
      # To access nested objects within a namespace, two methods are available:
      #
      # 1. #nest_one: Used for single nested objects, such as if a `User belongs_to :profile` in
      #    ActiveRecord. This method returns another Namespace object.
      #
      # 2. #nest_many: Used for collections of nested objects, such as if a `User has_many :addresses` in
      #    ActiveRecord. This method returns a NamespaceCollection object.
      class Namespace < Structure::Node
        include Enumerable

        attr_reader :builder_klass, :object

        def initialize(key, parent:, builder_klass:, object: nil)
          super(key, parent: parent)
          @builder_klass = builder_klass
          @object = object
          @children = {}
          yield self if block_given?
        end

        def field(key, **attributes)
          create_child(key, attributes.delete(:builder_klass) || builder_klass, object: object, **attributes).tap do |field|
            yield field if block_given?
          end
        end

        # Creates a `Namespace` child instance with the parent set to the current instance, adds to
        # the `@children` Hash to ensure duplicate child namespaces aren't created, then calls the
        # method on the `@object` to get the child object to pass into that namespace.
        #
        # For example, if a `User#permission` returns a `Permission` object, we could map that to a
        # display like this:
        #
        # ```ruby
        # Phlexi::Display(user) do |display|
        #   display.nest_one :profile do |profile|
        #     render profile.field(:gender).text
        #   end
        # end
        # ```
        def nest_one(key, object: nil, &)
          object ||= object_value_for(key: key)
          create_child(key, self.class, object:, builder_klass:, &)
        end

        # Wraps an array of objects in Namespace classes. For example, if `User#addresses` returns
        # an enumerable or array of `Address` classes:
        #
        # ```ruby
        # Phlexi::Display(user) do |display|
        #   render display.field(:email).text
        #   render display.field(:name).text
        #   display.nest_many :addresses do |address|
        #     render address.field(:street).text
        #     render address.field(:state).text
        #     render address.field(:zip).text
        #   end
        # end
        # ```
        # The object within the block is a `Namespace` object that maps each object within the enumerable
        # to another `Namespace` or `Field`.
        def nest_many(key, collection: nil, &)
          collection ||= Array(object_value_for(key: key))
          create_child(key, NamespaceCollection, collection:, &)
        end

        # Iterates through the children of the current namespace, which could be `Namespace` or `Field`
        # objects.
        def each(&)
          @children.values.each(&)
        end

        def dom_id
          @dom_id ||= begin
            id = if object.nil?
              nil
            elsif object.class.respond_to?(:primary_key)
              object.public_send(object.class.primary_key) || :new
            elsif object.respond_to?(:id)
              object.id || :new
            end
            [key, id].compact.join("_").underscore
          end
        end

        # Creates a root Namespace
        def self.root(*, builder_klass:, **, &)
          new(*, parent: nil, builder_klass:, **, &)
        end

        protected

        # Calls the corresponding method on the object for the `key` name, if it exists. For example
        # if the `key` is `email` on `User`, this method would call `User#email` if the method is
        # present.
        #
        # This method could be overwritten if the mapping between the `@object` and `key` name is not
        # a method call. For example, a `Hash` would be accessed via `user[:email]` instead of `user.send(:email)`
        def object_value_for(key:)
          @object.send(key) if @object.respond_to? key
        end

        private

        # Checks if the child exists. If it does then it returns that. If it doesn't, it will
        # build the child.
        def create_child(key, child_class, **kwargs, &block)
          @children.fetch(key) { @children[key] = child_class.new(key, parent: self, **kwargs, &block) }
        end
      end
    end
  end
end
