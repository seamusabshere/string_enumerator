# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "string_enumerator/version"

Gem::Specification.new do |s|
  s.name        = "string_enumerator"
  s.version     = StringEnumerator::VERSION
  s.authors     = ["Seamus Abshere"]
  s.email       = ["seamus@abshere.net"]
  s.homepage    = "https://github.com/seamusabshere/string_enumerator"
  s.summary     = %q{Given a string containing placeholders (like [color]), enumerate all of the possible strings resulting from filling those placeholders with replacements (like red, blue).}
  s.description = %q{Fill strings that have placeholders like [color], possibly returning multiple results.}

  s.rubyforge_project = "string_enumerator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'brighter_planet_metadata'
end
