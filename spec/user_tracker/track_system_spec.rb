require "spec_helper"

describe UserTracker::TrackSystem do
  let(:system) { UserTracker::TrackSystem.new }

  it "should initialize" do
    system.track("New event", nil)
  end 
end