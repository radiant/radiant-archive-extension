module ArchiveMenuRenderer
  def excluded_class_names
    excluded_from_this = Array(ArchiveMenuRenderer.instance_variable_get(:@excluded_class_names))
    if defined?(super)
      return super + excluded_from_this
    end
    excluded_from_this
  end
end

module ArchiveDayIndexMenuRenderer
  def add_child_disabled?
    true
  end
end

module ArchiveMonthIndexMenuRenderer
  def add_child_disabled?
    true
  end
end

module ArchiveYearIndexMenuRenderer
  def add_child_disabled?
    true
  end
end