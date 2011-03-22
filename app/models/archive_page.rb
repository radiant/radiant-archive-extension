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
    year, month, day = $1, ($2 || 1).to_i, ($3 || 1).to_i if child.request and child.request.request_uri =~ %r{/(\d{4})(?:/(\d{2})(?:/(\d{2}))?)?/?$}
    
    if year && %w{ ArchiveYearIndexPage ArchiveMonthIndexPage ArchiveDayIndexPage }.include?(child.class_name)
      date = Date.new(year.to_i, month, day)
      if ArchiveYearIndexPage === child
        clean_path "#{ path }/#{ date.strftime '%Y' }/"
      elsif ArchiveMonthIndexPage === child
        clean_path "#{ path }/#{ date.strftime '%Y/%m' }/"
      else ArchiveDayIndexPage === child
        clean_path "#{ path }/#{ date.strftime '%Y/%m/%d/' }/"
      end
    else
      if child.published_at?
        clean_path "#{ path }/#{ child.published_at.strftime '%Y/%m/%d' }/#{ child.slug }"
      else
        clean_path "#{ path }/#{ Time.zone.now.strftime '%Y/%m/%d' }/#{ child.slug }"
      end
    end
  end
  def child_url(child)
    ActiveSupport::Deprecation.warn("`child_url' has been deprecated; use `child_path' instead.", caller)
    child_path(child)
  end
  
  def find_by_path(path, live = true, clean = false)
    path = clean_path(path) if clean
    if path =~ %r{^#{ self.path }(\d{4})(?:/(\d{2})(?:/(\d{2})(?:/([-_.A-Za-z0-9]*))?)?)?/?$}
      year, month, day, slug = $1, $2, $3, $4
      children.find_by_class_name(
        case
        when slug.present?
          found = children.find_by_slug(slug)
          return found if found
        when day.present?
          'ArchiveDayIndexPage'
        when month.present?
          'ArchiveMonthIndexPage'
        else
          'ArchiveYearIndexPage'
        end
      )
    else
      super
    end
  end
  def find_by_url(*args)
    ActiveSupport::Deprecation.warn("`find_by_url' has been deprecated; use `find_by_path' instead.", caller)
    find_by_path(*args)
  end
end
