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

  s.metadata["source_code_uri"] = "https://github.com/matique/miau"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.authors = ["Dittmar Krall"]
  s.email = "dittmar.krall@matique.com"
  s.homepage = "https://matique.com"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }

  s.add_runtime_dependency "activesupport"

  s.add_development_dependency "activemodel"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "rake"

  s.add_development_dependency "minitest"
  s.add_development_dependency "ricecream"
end
