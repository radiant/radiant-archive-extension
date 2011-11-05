require 'spec_helper'

describe ArchiveMenuRenderer do
  context 'excluding classes from child list' do
    it 'should be retrievable by the extended object' do
      ArchiveMenuRenderer.instance_variable_set(:@excluded_class_names, ['SkippedPage'])
      page = Object.new
      page.extend ArchiveMenuRenderer
      page.excluded_class_names.should include('SkippedPage')
    end
  end
end

describe ArchiveDayIndexMenuRenderer do
  subject{
    page = Object.new
    page.extend ArchiveDayIndexMenuRenderer
    page
  }
  its(:add_child_disabled?){ should be_true }
end

describe ArchiveMonthIndexMenuRenderer do
  subject{
    page = Object.new
    page.extend ArchiveMonthIndexMenuRenderer
    page
  }
  its(:add_child_disabled?){ should be_true }
end

describe ArchiveYearIndexMenuRenderer do
  subject{
    page = Object.new
    page.extend ArchiveYearIndexMenuRenderer
    page
  }
  its(:add_child_disabled?){ should be_true }
end