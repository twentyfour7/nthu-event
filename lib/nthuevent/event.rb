# frozen_string_literal: true
require_relative 'nthu_event_api'

module NthuEvent
  # Single event on organiztion's feed
  class Event
    attr_reader :title, :content, :url, :date

    def initialize(event_data)
      load_data(event_data)
    end

    def self.find(type: nil, page: nil)
      events_data = NthuEvent::NthuEventApi.events(type: type, page: page)
      events = events_data.map do |event_data|
        new(event_data)
      end
      events
    end

    private

    def load_data(event_data)
      @title = event_data[:title]
      @content = event_data[:content]
      @url = event_data[:url]
      @date = event_data[:date]
    end
  end
end
