# frozen_string_literal: true

require_relative "lib/miau/version"

Gem::Specification.new do |s|
  s.name = "miau"
  s.version = Miau::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = %(Simple and lightweight authorization solution for Rails.)

  s.description = <<~EOS
    MIAU (MIcro AUthorization) provides some helpers which
    raises an exception if a given user violates a policy.
  EOS

  s.authors = ["Dittmar Krall"]
  s.email = "dittmar.krall@matiq.com"
  s.homepage = "https://github.com/matique/miau"
  s.license = "MIT"

  # s.files = `git ls-files`.split("\n")
  s.files = Dir["lib/**/*"]
  s.extra_rdoc_files = Dir["README.md", "MIT-LICENSE"]

  s.require_paths = ["lib"]

  s.add_dependency "listen"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "combustion"
  s.add_development_dependency "minitest"
  s.add_development_dependency "ricecream"
end
