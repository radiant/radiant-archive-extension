require File.dirname(__FILE__) + '/../spec_helper'

describe ArchiveMonthIndexPage do
  dataset :archive
  
  before :each do
    @page = pages(:month_index)
  end
  
  its(:allowed_children){ should == [] }
  
  it_should_behave_like "Archive index page"
  
  it "should render the <r:archive:children:each /> tag" do
    @page.should render('<r:archive:children:each><r:slug /> </r:archive:children:each>').as('article-y ').on('/archive/2001/02/')
    @page.should render('<r:archive:children:each><r:slug /> </r:archive:children:each>').as('article-y ').on('/archive/2001/02')
  end
  
  it "should render the <r:title /> tag with interpolated date" do
    @page.should render('<r:title />').as('June 2000 Archive').on('/archive/2000/06/')
  end

  it "should render the <r:breadcrumb /> tag with interpolated date" do
    @page.should render('<r:breadcrumb />').as('June 2000 Archive').on('/archive/2000/06/')
  end

  it "should render the <r:path /> tag with interpolated date" do
    @page.should render('<r:path />').as('/archive/2000/06/').on('/archive/2000/06')
  end

  it "should properly render the <r:path /> tag of an archive child with interpolated date" do
    @page.should render('<r:archive:children:each><r:path /> </r:archive:children:each>').as('/archive/2000/01/01/article-z/ /archive/2000/01/02/early-post/ /archive/2000/01/03/z-post/ /archive/2000/01/04/a-post/ ').on('/archive/2000/01/')
  end
end
