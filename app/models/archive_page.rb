class ArchivePage < Page
  cattr_accessor :allowed_children
  cattr_accessor :single_use_children
  @@single_use_children = [ArchiveDayIndexPage, ArchiveMonthIndexPage, ArchiveYearIndexPage, FileNotFoundPage]
  @@allowed_children = [Page, *@@single_use_children]
  
  def allowed_children
    allowed = @@allowed_children.dup
    existing_types = children.all(:select => 'DISTINCT class_name, virtual, title').map(&:class_name)
    overlap = allowed.map(&:to_s) & existing_types
    
    allowed - overlap.map!(&:constantize)
  end

  description %{
    An archive page provides behavior similar to a blog archive or a news
    archive. Child page URLs are altered to be in %Y/%m/%d format
    (2004/05/06).
    
    An archive page can be used in conjunction with the "Archive Year Index",
    "Archive Month Index", and "Archive Day Index" page types to create year,
    month, and day indexes.
  }
  
  def child_url(child)
    date = child.published_at || Time.now
    clean_url "#{ url }/#{ date.strftime '%Y/%m/%d' }/#{ child.slug }"
  end
  
  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if url =~ %r{^#{ self.url }(\d{4})(?:/(\d{2})(?:/(\d{2}))?)?/?$}
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
end