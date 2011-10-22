require File.expand_path("../../spec_helper", __FILE__)

describe ArchiveYearIndexPage do
  dataset :archive
  
  before :each do
    @page = pages(:year_index)
  end
  
  its(:allowed_children){ should == [] }
  
  it_should_behave_like "Archive index page"
  
  it "should render the <r:archive:children:each /> tag" do
    @page.should render('<r:archive:children:each><r:slug /> </r:archive:children:each>').as('article-y ').on('/archive/2001/')
    @page.should render('<r:archive:children:each><r:slug /> </r:archive:children:each>').as('article-y ').on('/archive/2001')
  end
  
  it "should render the <r:title /> tag with interpolated date" do
    @page.should render('<r:title />').as('2000 Archive').on('/archive/2000')
  end

  it "should render the <r:breadcrumb /> tag with interpolated date" do
    @page.should render('<r:breadcrumb />').as('2000 Archive').on('/archive/2000')
  end

  it "should render the <r:url /> tag with interpolated date" do
    @page.should render('<r:url />').as('/archive/2000/').on('/archive/2000')
  end

end
