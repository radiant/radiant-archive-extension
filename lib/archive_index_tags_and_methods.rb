module ArchiveIndexTagsAndMethods
  
  include Radiant::Taggable
  
  desc %{
    Scope tags for an ArchivePage
  }
  tag "archive" do |tag|
    tag.expand
  end
  
  [:title, :breadcrumb].each do |method|
    tag method.to_s do |tag|
      setup_date_parts
      page = tag.locals.page
      unless @year.nil?
        Date.new((@year || 1).to_i, (@month || 1).to_i, (@day || 1).to_i).strftime(page.send(method))
      else
        page.send(method)
      end
    end
  end
  
  desc %{
    Display the year for the current Archive
  }
  tag "archive:year" do |tag|
    setup_date_parts
    @year.to_i unless @year.nil?
  end
  

  desc %{
    Display the month for the current Archive
  }
  tag "archive:month" do |tag|
    setup_date_parts
    Date.new(@year.to_i, @month.to_i, 1).strftime('%B') rescue ''
  end
  

  desc %{
    Display the day for the current Archive
  }
  tag "archive:day" do |tag|
    setup_date_parts
    @day.to_i unless @day.nil?
  end
  

  desc %{
    Display the day of the week for the current Archive
  }
  tag "archive:day_of_week" do |tag|
    setup_date_parts
    Date.new(@year.to_i, @month.to_i, @day.to_i).strftime('%A') rescue ''
  end
  
  tag("archive:children:first") { "unimplemented" }
  tag("archive:children:last" ) { "unimplemented" }
  tag("archive:children:count") { "unimplemented" }
  
  def virtual?
    true
  end
  
  private
    
    def request_uri
      request.request_uri unless request.nil?
    end
    
    def setup_date_parts
      @year, @month, @day = $1, $2, $3 if request_uri =~ %r{/(\d{4})(?:/(\d{2})(?:/(\d{2}))?)?/?$}
    end
  
end
