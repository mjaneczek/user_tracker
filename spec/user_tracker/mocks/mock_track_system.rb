class MockTrackSystem
  def track(event_name, parameters)
    puts "Name: #{event_name}, parameters: #{parameters}"
    tracked_events.push(event_name: event_name, parameters: parameters)
  end

  def tracked_events
    @tracked_events ||= []
  end
end