require "rubygems"
require "bundler/gem_tasks"
require "rake/testtask"

desc "Run all tests"
Rake::TestTask.new do |t|
  t.libs.push "test"
  t.pattern = "test/*_test.rb"
end

desc "Default: run unit tests."
task default: :test
