module ApplicationHelper
  def time(time, label, options={})
    options[:pubdate] = "pubdate" if options[:pubdate]
    content_tag(:time, label, options)
  end

  def entry_time(entry)
    time(
      entry.created_at,
      time_ago_in_words(entry.created_at)+" ago",
      pubdate: true)
  end
end
