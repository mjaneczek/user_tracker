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

    expect(@tracker.tracks.last).to eq(action_name: :update, subject: ApplicationController, event_name: "Update!", block: nil)

    @tracker.tracks.first[:block].call
    expect(should_change_to_true).to be_true
  end 
end