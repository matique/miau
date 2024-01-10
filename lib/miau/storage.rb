# frozen_string_literal: true

require "singleton"
require "yaml"

module Miau
  class PolicyStorage
    include Singleton

    # Example @policies:
    # {
    #   posts: {
    #     delete: :delete,
    #     remove: :delete
    #   },
    #   application: {
    #     admin: :check
    #   }
    # }
    attr_reader :policies
    attr_reader :instances # { posts: PostsPolicy.new }

    def initialize
      reset
    end

    def reset
      @policies = {}
      @instances = {}
    end

    def add_policy(kls, action, meth)
      kls = kls.to_sym
      action = action.to_sym
      @policies[kls] ||= {}
      if @policies[kls][action]
        raise OverwriteError, "Can't overwrite policy(#{kls}, #{action})"
      end

      if meth.is_a?(Array)
        # meths = [meth].flatten.collect { |m| m.to_sym }
        meths = [meth].flatten.collect(&:to_sym)
        @policies[kls][action] = meths
      else
        @policies[kls][action] = meth.to_sym
      end
    end

    def find_or_create_policy(klass)
      res = @instances[klass]
      return res unless res.nil?

      name = "#{klass.to_s.camelcase}Policy"
      return nil unless Object.const_defined?(name)

      instances[klass] = name.constantize.new
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies) +
        "# === @instances ===\n" + YAML.dump(@instances)
    end
  end
end
