class ArchivePage < Page
  cattr_accessor :allowed_children
  cattr_accessor :single_use_children
  @@single_use_children = [ArchiveDayIndexPage, ArchiveMonthIndexPage, ArchiveYearIndexPage, FileNotFoundPage]
  @@allowed_children = [self.default_child, *@@single_use_children]
  
  def allowed_children
    overlap = @@allowed_children & (existing_child_types - [default_child])
    
    (@@allowed_children - overlap)
  end
  
  def existing_child_types
    children(:select => 'DISTINCT class_name', :order => nil).collect{|p| p.class }.uniq
  end

  description %{
    An archive page provides behavior similar to a blog archive or a news
    archive. Child page URLs are altered to be in %Y/%m/%d format
    (2004/05/06).
    
    An archive page can be used in conjunction with the "Archive Year Index",
    "Archive Month Index", and "Archive Day Index" page types to create year,
    month, and day indexes.
  }
  
  def child_path(child)
    date = child.published_at || Time.now
    clean_path "#{ path }/#{ date.strftime '%Y/%m/%d' }/#{ child.slug }"
  end
  alias_method :child_url, :child_path
  
  def find_by_path(path, live = true, clean = false)
    path = clean_path(path) if clean
    if path =~ %r{^#{ self.path }(\d{4})(?:/(\d{2})(?:/(\d{2}))?)?/?$}
      year, month, day = $1, $2, $3
      children.find_by_class_name(
        case
        when day
          'ArchiveDayIndexPage'
        when month
          'ArchiveMonthIndexPage'
        else
          'ArchiveYearIndexPage'
        end
      )
    else
      super
    end
  end
  alias_method :find_by_url, :find_by_path
end
