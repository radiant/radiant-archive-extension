require File.dirname(__FILE__) + '/../spec_helper'

describe ArchivePage do
  dataset :archive
  
  let(:archive){ pages(:archive) }
  
  it "should not render archive index pages" do
    archive.should render('<r:children:each><r:slug /> </r:children:each>').as('article-z early-post z-post a-post article-y article-x article-w article-v ')
  end
  
  it "should scope child URLs by date" do
    pages(:article_z).url.should == '/archive/2000/01/01/article-z/'
  end
  
  it "should scope unpublished children by the current date" do
    pages(:draft_article).url.should == '/archive/' + Time.zone.now.strftime('%Y/%m/%d') + '/draft-article/'
  end
  
  it "should find the year index" do
    archive.find_by_path('/archive/2000/').should == pages(:year_index)
  end
  
  it "should find the month index" do
    archive.find_by_path('/archive/2000/06/').should == pages(:month_index)
  end
  
  it "should find the day index" do
    archive.find_by_path('/archive/2000/06/09/').should == pages(:day_index)
  end
  
  it "should find child URLs from the homepage" do
    pages(:home).find_by_path('/archive/2000/01/01/article-z/').should == pages(:article_z)
  end
  
  its(:single_use_children){ should == [ArchiveDayIndexPage, ArchiveMonthIndexPage, ArchiveYearIndexPage, FileNotFoundPage]}
  its(:allowed_children){ should == [Page, *ArchivePage.single_use_children]}
  
  describe '#existing_child_types' do
    it 'should return a unique array of classes of the page children' do
      archive.existing_child_types.should == archive.children.all(:select => 'DISTINCT class_name').collect{|p| p.class }.uniq
    end
  end
  
  describe '#allowed_children' do
    context 'when no children exist' do
      subject{ ArchivePage.new }
      its(:allowed_children){ should == ArchivePage.allowed_children }
    end
    it 'should remove any existing single_use_children from the allowed_children' do
      existing_except_default = archive.existing_child_types - [archive.default_child]
      used_allowed_children = ArchivePage.allowed_children & existing_except_default
      archive.allowed_children.should == (ArchivePage.allowed_children - used_allowed_children)
    end
  end
end