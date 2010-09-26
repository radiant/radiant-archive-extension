require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  its(:default_child){ should == Page}
  its(:allowed_children){ should == [Page, *Page.descendants.sort_by(&:name)].select(&:in_menu?).reject{|p| p.name =~ /Archive(Day|Month|Year)IndexPage/}}
end