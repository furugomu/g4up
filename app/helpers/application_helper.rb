# -*- encoding: UTF-8 -*-
module ApplicationHelper
  def time(time, label, options={})
    options[:pubdate] = "pubdate" if options[:pubdate]
    content_tag(:time, label, options)
  end

  def entry_time(entry)
    time(
      entry.created_at,
      l(entry.created_at),
      pubdate: true)
  end

  def idol_names
    %w(亜美 真美 やよい 伊織 美希 千早 響 春香 雪歩 真 貴音 律子 あずさ)
  end
end
