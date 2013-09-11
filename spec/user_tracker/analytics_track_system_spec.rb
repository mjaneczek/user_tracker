require "spec_helper"

describe UserTracker::AnalyticsTrackSystem do
  let(:system) { UserTracker::AnalyticsTrackSystem.new("secret_key") }

  it "should initialize" do
    allow(Analytics).to receive(:init)
    allow(Analytics).to receive(:identify)
    allow(Analytics).to receive(:track)

    expect(Analytics).to receive(:init).ordered.
      with(secret: "secret_key")
    expect(Analytics).to receive(:identify).ordered.
      with(user_id: User.instance.id, traits: { email: User.instance.email })
    expect(Analytics).to receive(:track).ordered.
      with(user_id: User.instance.id, event: "New event", properties: { test: true })

    system.track("New event", User.instance, { test: true })
  end

  it "should change user additional parameters" do
    system.user_additional_parameters = -> (user) { { id: user.id, name: user.name } }
    expect(Analytics).to receive(:identify).
      with(user_id: User.instance.id, traits: { id: User.instance.id, name: User.instance.name })

    system.track("New event", User.instance, nil)
  end 
end