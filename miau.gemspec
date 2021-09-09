lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "miau/version"

Gem::Specification.new do |s|
  s.name = "miau"
  s.version = Miau::VERSION
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@matique.com"]

  s.summary = %(Simple and lightweight authorization solution for Rails.)
  s.description = <<~EOS
    Miau provides a set of helpers which restricts what
    resources a given user is allowed to access.
  EOS
  s.homepage = "https://github.com/matique/miau"
  s.license = "MIT"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activesupport"

  s.add_development_dependency "activemodel"
  s.add_development_dependency "actionpack"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"

  s.add_development_dependency "minitest"
  s.add_development_dependency "ricecream"
end
