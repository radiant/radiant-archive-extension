# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-archive-extension/version"

Gem::Specification.new do |s|
  s.name        = "radiant-archive-extension"
  s.version     = RadiantArchiveExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Radiant CMS Dev Team"]
  s.email       = ["radiant@radiantcms.org"]
  s.homepage    = "http://radiantcms.org"
  s.summary     = %q{Archive for Radiant CMS}
  s.description = %q{Provides page types for news or blog archives.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.post_install_message = %{
  Add this to your radiant project with:
    config.gem 'radiant-archive-extension', :version => '#{RadiantArchiveExtension::VERSION}'
  }
end