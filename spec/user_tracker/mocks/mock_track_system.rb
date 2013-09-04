class MockTrackSystem
  def track(event_name, user, parameters)
    tracked_events.push(event_name: event_name, user: user, parameters: parameters)
  end

  def tracked_events
    @tracked_events ||= []
  end
end