if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end
end

ENV["RAILS_ENV"] ||= "test"

require "miau"

require "rack"
require "rack/test"
require "active_support"
require "active_support/core_ext"
require "action_controller/metal/strong_parameters"

require "minitest/autorun"
require "ricecream"

I18n.enforce_available_locales = false

support = File.expand_path("../test/support", __dir__)
$LOAD_PATH.unshift support
Dir["#{support}/**/*.rb"].each { |f| require f }
