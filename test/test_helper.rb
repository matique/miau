if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
    coverage_dir "tmp/coverage"
  end
end

ENV["RAILS_ENV"] ||= "test"

require "miau"

#require "rack"
#require "rack/test"
require "active_support"
require "active_support/core_ext"

require "minitest/autorun"
require "ricecream"

support = File.expand_path("../test/support", __dir__)
$LOAD_PATH.unshift support
Dir["#{support}/**/*.rb"].each { |f| require f }
