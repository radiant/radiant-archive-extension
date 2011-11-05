module ArchiveMenuRenderer
  def excluded_class_names
    Array(ArchiveMenuRenderer.instance_variable_get(:@excluded_class_names))
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