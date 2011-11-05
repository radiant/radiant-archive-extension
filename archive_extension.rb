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
      ArchiveMenuRenderer # Initialize the class because it is lazily loaded
      MenuRenderer.exclude 'ArchiveDayIndexPage', 'ArchiveMonthIndexPage', 'ArchiveYearIndexPage'
      Page.class_eval do
        include PageChildrenCacheUpdates
      end
    end
  end
end
