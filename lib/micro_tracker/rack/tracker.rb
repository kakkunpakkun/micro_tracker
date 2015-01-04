require 'rack/utils'

module MicroTracker
  module Rack
    class Tracker
      include ::Rack::Utils

      MICRO_TRACKER_REQ_ID = "Micro-Tracker-Req-ID"

      def initialize(app)
        @app = app
      end

      def call(env)
        unless env[MICRO_TRACKER_REQ_ID]
          now = Time.now.strftime("%Y%m%d%H%M%S")
          env[MICRO_TRACKER_REQ_ID] = "#{now}-#{Identifier.generate}"
        end

        @app.call(env)
      end
    end
  end
end
