require_relative "lib/miau/version"

Gem::Specification.new do |s|
  s.name = "miau"
  s.version = Miau::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = %(Simple and lightweight authorization solution for Rails.)
  s.license = "MIT"

  s.description = <<~EOS
    MIAU (MIcro AUthorization) provides a set of helpers which restricts what
    resources a given user is allowed to access.
  EOS

  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.authors = ["Dittmar Krall"]
  s.email = "dittmar.krall@matiq.com"
  s.homepage = "https://github.com/matique/miau"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }

  s.add_runtime_dependency "activesupport"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "minitest"
  s.add_development_dependency "ricecream"
end
