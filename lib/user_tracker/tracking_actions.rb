module UserTracker
  module TrackingActions
    def track(action_name, subject, event_name, &block)
      tracks.push(action_name: action_name, subject: subject, event_name: event_name, block: block)
    end

    def tracks
      @tracks ||= []
    end
  end
end