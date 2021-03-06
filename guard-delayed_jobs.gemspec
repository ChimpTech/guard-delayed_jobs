# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/delayed_jobs/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-delayed_jobs"
  spec.version       = Guard::DelayedJobsVersion::VERSION
  spec.authors       = ["David Alexander"]
  spec.email         = ["rubygems@thelonelyghost.com"]

  spec.summary       = %q{A short summary, because Rubygems requires one.}
  spec.homepage      = "https://github.com/thelonelyghost/guard-delayed_jobs"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'guard', '~> 2.1'
  spec.add_dependency 'guard-compat', '~> 1.1'
  spec.add_dependency 'delayed_job', '>= 3.0', '< 5'
  spec.add_dependency 'cocaine', '~> 0.5.8'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
