# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nv_helpers/version"

Gem::Specification.new do |s|
  s.name        = "nv_helpers"
  s.version     = NvHelpers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pat O'Brien"]
  s.email       = ["pobrien@eharmony.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  # probably don't want to push here
  #s.rubyforge_project = "nv_helpers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  #s.add_runtime_dependency ""
end
