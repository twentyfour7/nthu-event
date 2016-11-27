require 'open-uri'
require 'nokogiri'
require 'uri'

admin_board_uri = 'http://bulletin.web.nthu.edu.tw/files/40-1912-5074-1.php?Lang=zh-tw'

doc = Nokogiri::HTML(open(admin_board_uri))

events = doc.css('div.h5').map do |node|
  date = node.css('.date').text.gsub(/[\[\]\s]+/, '')
  event_node = node.css('.ptname a')
  link = URI.join(admin_board_uri, event_node.attr('href').value)
  title = event_node.attr('title').value
  content_doc = Nokogiri::HTML(open(link))
  content = content_doc.css('.ptcontent').text.strip

  { title: title, content: content, link: link, date: date }
end

events.each do |event|
  puts event
end
