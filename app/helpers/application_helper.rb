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

  def entry_full_path(entry)
    polymorphic_path([:full, entry], filename: entry.filename)
  end

  def entry_full_url(entry)
    polymorphic_url([:full, entry], filename: entry.filename)
  end

  def article(options={}, &block)
    content_tag_compat(:article, options, &block)
  end
  def section(options={}, &block)
    content_tag_compat(:section, options, &block)
  end
  def header(options={}, &block)
    content_tag_compat(:header, options, &block)
  end
  def footer(options={}, &block)
    content_tag_compat(:footer, options, &block)
  end

  def ps3?
    request.headers['User-Agent'].to_s.include?('PLAYSTATION 3')
  end

  def lazy_image(src, options={})
    if request.xhr?
      return image_tag(src, options)
    end
    script = javascript_tag(
      'document.write("' +
      j(image_tag('blank.gif', {'data-src'=>src}.merge(options))) +
      '");')
    noscript = content_tag(:noscript, image_tag(src, options))
    script+noscript
  end

  private

  # html5 を使えない人々
  def legacy?
    ps3? || true
  end

  def content_tag_compat(name, options={}, &block)
    if legacy?
      options[:class] =
        [options[:class], name.to_s].reject(&:blank?).join(' ')
      name = :div
    end
    content_tag(name, options, &block)
  end
end
