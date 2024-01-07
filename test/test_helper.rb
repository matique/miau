if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
    coverage_dir "tmp/coverage"
  end
end

ENV["RAILS_ENV"] ||= "test"

require "miau"

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :active_record

require "minitest/autorun"
require "rails/test_help"
