require "spec_helper"

describe UserTracker::TracksExecutor do
  let(:controller) { MockController.new }
  let(:executor) { UserTracker::TracksExecutor }
  let(:track_system) { MockTrackSystem.new }
  before(:each) do 
    executor.initialize
    executor.track_system = track_system
  end

  it "should pass event to track system" do
    controller.create
    controller.update

    track_system.tracked_events.should eq(
      [{event_name: "Created!", parameters: nil}, {event_name: "Updated!", parameters: nil}])
  end

  it "check source" do
    executor.source.count.should eq 2
  end 

  it "should create instance of track system just one time" do
    executor.track_system = JustOneTrackSystem.new

    controller.create
    controller.create
  end

  class JustOneTrackSystem
    def initialize
      raise RuntimeError if defined?(@@initialized)
      @@initialized = true
    end

    def track(name, args)
    end
  end

  class TrackingActions
    include UserTracker::TrackingActions

    def initialize
      track :create, MockController, "Created!"
      track :update, MockController, "Updated!"
    end
  end
end