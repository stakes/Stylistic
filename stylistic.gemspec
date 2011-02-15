# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stylistic/version"

Gem::Specification.new do |s|
  s.name        = "stylistic"
  s.version     = Stylistic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jay Stakelon"]
  s.email       = ["stakes@jaystakelon.com"]
  s.homepage    = ""
  s.summary     = %q{Upgrade your default stylesheet and much more}
  s.description = %q{This gem will help make your Rails project so stylistic by installing (better) default scaffold styles, popular CSS grid frameworks and jQuery.}

  s.rubyforge_project = "stylistic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
