# -*- encoding: UTF-8 -*-
module ApplicationHelper
  def time(time, label, options={})
    options[:pubdate] = "pubdate" if options[:pubdate]
    content_tag(:time, label, options)
  end

  def relative_time(time)
    now = Time.current.time
    return time.strftime('%Y/%m/%d %H:%M') if now.year != time.year
    return time.strftime('%m/%d %H:%M') if now.month != time.month
    return time.strftime('%m/%d %H:%M') if now.day != time.day
    time.strftime('%H:%M')
  end

  def entry_time(entry)
    time(
      entry.created_at,
      relative_time(entry.created_at),
      pubdate: true)
  end

  def idol_names
    %w(亜美 真美 やよい 伊織 美希 千早 響 春香 雪歩 真 貴音 律子 あずさ)
  end
end
