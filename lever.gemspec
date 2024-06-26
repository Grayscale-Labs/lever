
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lever/version"

Gem::Specification.new do |spec|
  spec.name          = "lever"
  spec.version       = Lever::VERSION
  spec.authors       = ["Hubert Liu"]
  spec.email         = ["hubert.c.liu@gmail.com"]

  spec.summary       = "API client for Lever.co"
  spec.description   = "API client for Lever.co"
  spec.homepage      = "https://grayscaleapp.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('hashie')
  spec.add_runtime_dependency('httparty', '~> 0.21.0')
  spec.add_runtime_dependency('retriable')
  spec.add_runtime_dependency('addressable', '~> 2.8.6')

  spec.add_development_dependency "bundler", "~> 2.2.33"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "factory_bot"
end
