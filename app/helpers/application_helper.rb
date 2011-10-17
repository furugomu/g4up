module ApplicationHelper
  def time(time, label, options={})
    options[:pubdate] = "pubdate" if options[:pubdate]
    content_tag(:time, label, options)
  end
end
