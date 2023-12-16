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

    def add(klass, action, meth)
      kls = klass.name.underscore[0..-8] # remove "_policy"
      kls = kls.to_sym
      @policies[kls] ||= {}
      @instances[kls] ||= klass.new
      if meth.is_a?(Array)
        meths = [meth].flatten.collect { |m| m.to_sym }
        @policies[kls][action.to_sym] = meths
      else
        @policies[kls][action.to_sym] = meth.to_sym
      end
    end

    def to_yaml
      "# === @policies ===\n" + YAML.dump(@policies) +
        "# === @instances ===\n" + YAML.dump(@instances)
    end
  end
end
