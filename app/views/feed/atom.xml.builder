xml.instruct! :xml, :version => "1.0" 
xml.feed(xmlns: 'http://www.w3.org/2005/Atom') do |feed|
  feed.title 'G4Up'
  feed.author{|a|a.name("|")}
  feed.id(href: root_url)
  feed.link(href: root_url)
  feed.link(rel: 'self', href: feed_atom_url)
  if (recent = @entries.first)
    feed.updated recent.updated_at.iso8601
  end
  @entries.each do |e|
    feed.entry do |entry|
      entry.id polymorphic_url(e)
      entry.title e.tag_list.join(' ')
      entry.link(href: entry_full_url(e))
      entry.published e.created_at.iso8601
      entry.updated e.updated_at.iso8601
      entry.content({type: 'html'}, <<-XML.squish)
       <p><img src="#{e.photo.url(:thumb)}" alt="" /></p>
       <p>#{e.body}</p>
      XML
    end
  end
end
