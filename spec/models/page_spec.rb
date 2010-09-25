require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  its(:default_child){ should == Page}
  its(:allowed_children){ should == [Page, ArchivePage, FileNotFoundPage]}
end