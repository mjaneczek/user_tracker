require "spec_helper"

describe UserTracker::TracksExecutor do
  let(:controller) { MockController.new }
  let(:executor) { UserTracker::TracksExecutor.new }
  let(:track_system) { MockTrackSystem.new }
  before(:each) do 
    executor.track_system = track_system
  end

  it "should pass event to track system" do
    controller.create
    controller.update

    expect(track_system.tracked_events).to eq(
      [{ event_name: "Created!", user: User.instance, parameters: {"Additional parameter" => "123"} },
       { event_name: "Updated!", user: User.instance, parameters: {"Updated item" => "Person"} }])
  end

  it "should track actions only from specific controller" do
    controller.create
    OtherMockController.new.update

    expect(track_system.tracked_events).to eq [{ event_name: "Created!", 
      user: User.instance, parameters: {"Additional parameter" => "123"} }]
  end

  it "should have source" do
    expect(executor.source.count).to eq 2
  end 

  it "should create instance of track system just one time" do
    executor.track_system = JustOneTrackSystem.new

    controller.create
    controller.create
  end

  describe "filters" do
    it "should register new filter" do
      executor.filters.push(Proc.new { false })

      controller.create
      expect(track_system.tracked_events.count).to eq 0
    end

    it "should register default filters" do
      expect(executor.filters).to eq [UserTracker::ActiveRecordValidationFilter, UserTracker::FlashErrorFilter]
    end

    it "should pass arguments to filter method" do
      executor.filters.push(Proc.new do |controller, action_name, event_name, parameters|
       expect(controller).to be_an_instance_of MockController 
       expect(action_name).to eq :create
       expect(event_name).to eq "Created!"
       expect(parameters).to eq({"Additional parameter" => "123" })
      end)

      controller.create
    end
  end

  class TrackingActions
    include UserTracker::TrackingActions

    def initialize
      track(:create, MockController, "Created!") { next {"Additional parameter" => "123" } } 
      track(:update, MockController, "Updated!") { next {"Updated item" => @update_item } }
    end
  end

  class JustOneTrackSystem
    def initialize
      raise RuntimeError if defined?(@@initialized)
      @@initialized = true
    end

    def track(name, user, args)
    end
  end

  class ItemController < ApplicationController; end
  class Item; end
end