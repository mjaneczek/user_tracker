class MockTrackSystem
  def track(event_name, parameters)
    tracked_events.push(event_name: event_name, parameters: parameters)
  end

  def tracked_events
    @tracked_events ||= []
  end
end