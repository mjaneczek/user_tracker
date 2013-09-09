require "spec_helper"

describe UserTracker::FlashErrorFilter do
  let (:filter) { UserTracker::FlashErrorFilter }
  let (:controller) { double("controller") }

  before(:each) do
    allow(controller).to receive(:flash).and_return(example.metadata[:flash_return])
  end

  after(:each) do
    expect(filter.call(controller, nil, nil, nil)).to eq example.metadata[:filter_return]
  end

  it("should return true if flash[:error] is not exist", 
    flash_return: { success: "Done!" }, filter_return: true) { }

  it("should return false if flash[:error] exists", 
    flash_return: { error: "Upps!" }, filter_return: false) { }
end