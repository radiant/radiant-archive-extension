require File.expand_path("../../spec_helper", __FILE__)

describe Page do
  context 'when the parent page has single_use_children' do
    it 'should remove its class from the parent page allowed_children_cache after create' do
      ArchivePage.stub!(:single_use_children).and_return([ArchiveDayIndexPage])
      parent = ArchivePage.create!(:slug => 'archive', :title => 'archive',
                          :breadcrumb => 'archive',
                          :allowed_children_cache => 'Page,ArchiveDayIndexPage')
      page = ArchiveDayIndexPage.new(:slug => 'day', :title => 'day', :breadcrumb => 'day')
      page.parent = parent
      page.save!
      parent.allowed_children_cache.should_not include('ArchiveDayIndexPage')
    end
    it 'should add its class to the parent page allowed_children_cache after destroy' do
      ArchivePage.stub!(:single_use_children).and_return([ArchiveDayIndexPage])
      parent = ArchivePage.create!(:slug => 'archive', :title => 'archive',
                          :breadcrumb => 'archive',
                          :allowed_children_cache => 'Page,ArchiveDayIndexPage')
      page = ArchiveDayIndexPage.new(:slug => 'day', :title => 'day', :breadcrumb => 'day')
      page.parent = parent
      page.save!
      page.destroy
      parent.allowed_children_cache.should include('ArchiveDayIndexPage')
    end
  end
end