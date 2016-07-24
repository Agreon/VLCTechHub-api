require 'active_support'
require 'active_support/core_ext'

module VLCTechHub
  module Event
    class Twitter
      include VLCTechHub::TwitterClient

      def self.tweet(event)
        new.update(event)
      end

      def update(event)
        tweet("Nuevo Evento: #{hashtag event} #{event['title']} #{datetime event} http://vlctechhub.org")
      end

      def tweet_today_events(today_events)
        today_events.each do |event|
          tweet("Hoy #{hashtag event}a las #{time event}: #{event['title']} http://vlctechhub.org")
        end
      end

      private

      def hashtag(event)
        hashtag = event['hashtag'] || ''
        hashtag += ' ' unless hashtag.empty?
        hashtag
      end

      def datetime(event)
        event['date'].strftime "%d/%m/%Y"
      end

      def time(event)
        event['date'].in_time_zone("Madrid").strftime "%H:%M"
      end
    end
  end
end
