require "spec_helper"

describe UserTracker::TrackSystem do
  let(:system) { UserTracker::TrackSystem.new("secret_key") }

  it "should initialize" do
    allow(Analytics).to receive(:init)
    allow(Analytics).to receive(:identify)
    allow(Analytics).to receive(:track)

    Analytics.should receive(:init).ordered.
      with(secret: "secret_key")
    Analytics.should receive(:identify).ordered.
      with(user_id: User.instance.id, traits: { name: User.instance.name, email: User.instance.email })
    Analytics.should receive(:track).ordered.
      with(user_id: User.instance.id, event: "New event", properties: { test: true })

    system.track("New event", User.instance, { test: true })
  end 
end