# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ArchiveExtension < Radiant::Extension
  version "1.0"
  description "Provides page types for news or blog archives."
  url "http://dev.radiantcms.org/"
    
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
  
  def deactivate
  end
  
end
