# frozen_string_literal: true
require 'open-uri'
require 'nokogiri'
require 'uri'

module NthuEvent
  # Service for all FB API calls
  class NthuEventApi
    BASE_URL = 'http://bulletin.web.nthu.edu.tw/files/'
    EVENT_TYPE_URL = {
      admin: '40-1912-5074',
      recruit_internal: '40-1912-5075',
      recruit_external: '40-1912-5081',
      admission: '40-1912-5082',
      art: '40-1912-5083',
      academic: '40-1912-5084',
      student: '40-1912-5085',
      others: '40-1912-5086'
    }.freeze

    def self.events(type: :admin, page: 0)
      type = EVENT_TYPE_URL[type.to_sym]
      events, totalpage = get_event_list("#{BASE_URL}#{type}-#{page}.php")
      return events if page.positive?

      # get all pages if page is zero
      (2..totalpage).each do |p|
        evnts, _total = get_event_list("#{BASE_URL}#{type}-#{p}.php")
        events += evnts
      end
      events
    end

    private_class_method

    def self.get_event_list(url)
      doc = Nokogiri::HTML(open(url))
      events = doc.css('div.h5').map do |node|
        date, link, title = parse_event_metadata(node)
        content = get_event_content(link)

        { title: title, content: content, link: link, date: date }
      end

      # get total page
      totalpage = get_pagenum_from_url(doc.css('#navigate a.pagenum').attr('href').value)
      [events, totalpage]
    end

    def self.parse_event_metadata(node)
      date = node.css('.date').text.gsub(/[\[\]\s]+/, '')
      event_node = node.css('.ptname a')
      link = URI.join(BASE_URL, event_node.attr('href').value)
      title = event_node.attr('title').value
      [date, link, title]
    end

    def self.get_event_content(url)
      content_doc = Nokogiri::HTML(open(url))
      content = content_doc.css('.ptcontent').text.strip
      content
    end

    private_class_method

    def self.get_pagenum_from_url(url)
      match_data = url.match('-(\d+)\.php')
      Integer(match_data.captures[0])
    end
  end
end
