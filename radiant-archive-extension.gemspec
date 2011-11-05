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
  
  ignoreable_commands = File.read('.gitignore').split("\n").delete_if{|line| line.match(/^##/) || line.empty? }
  ignoreable_files = ignoreable_commands.collect{|line| 
    if File.directory?(line)
      line + "/**/*"
    elsif File.file?(line)
      line
    end
  }.compact
  
  s.files = Dir['**/*','.gitignore'] - Dir[*ignoreable_files]

  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - Dir[*ignoreable_files]
  
  s.require_paths = ["lib"]
  
end