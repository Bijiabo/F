require 'stamp'

module ApplicationHelper

  def full_title(page_title = '')
    base_title = ENV['Base_title']
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_date(date)
    date.stamp("March 1 at 01:00 AM")
  end

end
