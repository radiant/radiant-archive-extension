# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
require 'radiant-archive-extension/version'
class ArchiveExtension < Radiant::Extension
  version RadiantArchiveExtension::VERSION
  description "Provides page types for news or blog archives."
  url "http://radiantcms.org/"
    
  def activate
    # allow bootstrap
    if Page.table_exists?
      Page.class_eval do
        def allowed_children_with_archive
          allowed_children_without_archive.reject { |p| p.name =~ /Archive(Day|Month|Year)IndexPage/ }
        end
        alias_method_chain :allowed_children, :archive
      end
    end
  end
end
