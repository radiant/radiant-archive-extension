module PageChildrenCacheUpdates
  def self.included(base)
    base.class_eval do
      after_create :remove_from_parent_allowed_children_cache
      after_destroy :add_to_parent_allowed_children_cache
    end
  end

  private

  def remove_from_parent_allowed_children_cache
    if parent_allows_this_child_class? && class_is_single_use_for_parent?
      parent.allowed_children_cache = parent_allowed_class_names.delete_if{|child| child == page_class_name }.join(',')
      parent.save
    end
  end

  def add_to_parent_allowed_children_cache
    if class_is_single_use_for_parent? && !parent_allows_this_child_class?
      parent.allowed_children_cache = (parent_allowed_class_names + [page_class_name]).uniq.join(',')
      parent.save
      true
    end
  end

  def parent_allows_this_child_class?
    parent? && parent.allowed_children_cache.to_s.split(',').include?(page_class_name)
  end

  def class_is_single_use_for_parent?
    parent? && parent.class.respond_to?(:single_use_children) && parent.class.single_use_children.map(&:name).include?(page_class_name)
  end

  def parent_allowed_class_names
    parent.allowed_children_cache.to_s.split(',')
  end

  def page_class_name
    self.class_name.present? ? self.class_name : 'Page'
  end
end