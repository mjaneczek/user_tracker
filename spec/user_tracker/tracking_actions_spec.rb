require "spec_helper"

describe UserTracker::TrackingActions do
  before(:each) do
    @tracker = Object.new
    @tracker.extend(UserTracker::TrackingActions)
  end

  it "should register new track action" do
    should_change_to_true = false
    lambda = -> { should_change_to_true = true }

    @tracker.track(:create, MockController, "Create!", &lambda)
    @tracker.track(:update, ApplicationController, "Update!")

    @tracker.tracks.last.should eq(action_name: :update, subject: ApplicationController, event_name: "Update!", block: nil)

    @tracker.tracks.first[:block].call
    should_change_to_true.should be_true
  end 
end