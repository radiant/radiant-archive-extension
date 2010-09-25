# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ArchiveExtension < Radiant::Extension
  version "1.0"
  description "Provides page types for news or blog archives."
  url "http://dev.radiantcms.org/"
    
  def activate
    # allow bootstrap
    if Page.table_exists?
      Page.class_eval {
        # in the case that page_menu is not loaded
        unless new.respond_to?(:default_child)
          def default_child
            Page
          end
        end
        def allowed_children
          [default_child, *Page.descendants.sort_by(&:name)].select(&:in_menu?).reject{|p| p.name =~ /Archive(Day|Month|Year)IndexPage/}
        end
      }
    end
  end
  
  def deactivate
  end
  
end
