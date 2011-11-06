require 'spec_helper'

module AnotherMenuRenderer
  def excluded_class_names
    ['AnotherPage']
  end
end
module ArchiveExcludingMenuRenderer
  def excluded_class_names
    ['ArchiveDayIndexPage','ArchiveMonthIndexPage','ArchiveYearIndexPage']
  end
end

describe ArchiveMenuRenderer do
  context 'excluding classes from child list' do
    it 'should be retrievable by the extended object' do
      ArchiveMenuRenderer.instance_variable_set(:@excluded_class_names, ['SkippedPage'])
      page = Object.new
      page.extend ArchiveMenuRenderer
      page.excluded_class_names.should include('SkippedPage')
    end
    it 'should contain excluded_class_names from the super class' do
      ArchiveMenuRenderer.instance_variable_set(:@excluded_class_names, ['SkippedPage'])
      page = Object.new
      page.extend ArchiveMenuRenderer
      page.extend AnotherMenuRenderer
      page.excluded_class_names.should include('AnotherPage')
    end
  end
  context 'excluded_class_names' do
    before{ 
      ArchiveMenuRenderer.instance_variable_set(:@excluded_class_names, ['SkippedPage'])
    }
    let(:page){
      page = Object.new
      page.extend ArchiveExcludingMenuRenderer
      page.extend ArchiveMenuRenderer
      page
    }
    subject{ page }
    its(:excluded_class_names){ should_not include('ArchiveDayIndexPage') }
    its(:excluded_class_names){ should_not include('ArchiveMonthIndexPage') }
    its(:excluded_class_names){ should_not include('ArchiveYearIndexPage') }
    its(:excluded_class_names){ should include('ArchivePage') }
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