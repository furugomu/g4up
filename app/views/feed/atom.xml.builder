xml.instruct! :xml, :version => "1.0" 
xml.feed(xmlns: 'http://www.w3.org/2005/Atom') do |feed|
  feed.title 'G4Up'
  feed.author{|a|a.name("|")}
  feed.id root_url
  feed.link(href: root_url)
  feed.link(rel: 'self', href: feed_atom_url)
  if (recent = @entries.first)
    feed.updated recent.updated_at.iso8601
  end
  @entries.each do |e|
    feed.entry do |entry|
      entry.id polymorphic_url(e)
      entry.title e.tags.map(&:name).join(' ')
      entry.link(href: entry_full_url(e), rel: 'alternate')
      if e.photo.present?
        entry.link(
          href: e.photo.url(:original),
          rel: 'enclosure',
          type: e.photo.content_type,
          length: e.photo.size)
      end
      entry.published e.created_at.iso8601
      entry.updated e.updated_at.iso8601

      entry.content({type: 'html'}, <<-XML.squish)
       <p>
        <a href="#{entry_full_url(e)}">
         <img src="#{e.photo.url(:thumb)}" alt="#{e.id}" border="0" />
        </a>
       </p>
       <p>#{h(e.body)}</p>
      XML
    end
  end
end
