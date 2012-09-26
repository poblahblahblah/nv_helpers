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
  s.summary     = %q{Helpers for dealing with nVentory}
  s.description = %q{This package includes helper scripts for dealing with nVentory}

  # probably don't want to push here
  #s.rubyforge_project = "nv_helpers"

  NV_IGNORE_FILES = %w{.rvmrc} unless defined?(NV_IGNORE_FILES)
  s.files         = `git ls-files`.split("\n") - NV_IGNORE_FILES
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "nventory-client"
end
