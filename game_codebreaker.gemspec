# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_codebreaker/version'

Gem::Specification.new do |spec|
  spec.name          = "game_codebreaker"
  spec.version       = GameCodebreaker::VERSION
  spec.authors       = ["woodcrust"]
  spec.email         = ["roboucrop@gmail.com"]

  spec.summary       = %q{This is game codebreaker for your terminal}
  spec.description   = %q{PLAY NOW!}
  spec.homepage      = "https://github.com/woodcrust/Codebreaker"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # # spec.files         = Dir['lib/**/*']
  # # spec.bindir        = "exe"
  # spec.bindir        = "bin"
  # # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # spec.executables   = ["game_codebreaker"]
  # spec.require_paths = ["lib"]

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["./"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.1"
end
