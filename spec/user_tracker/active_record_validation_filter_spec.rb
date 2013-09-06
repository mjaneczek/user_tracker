require "spec_helper"

describe UserTracker::ActiveRecordValidationFilter do
  let (:filter) { UserTracker::ActiveRecordValidationFilter }
  let (:product) { double("product") }
  let (:controller) do
    controller = ProductController.new
    controller.instance_variable_set :@product, product
    controller
  end

  it "should return true if variable is not exist" do
    expect(filter.call(ProductController.new, nil, nil, nil)).to be_true
  end

  it "should return true if variable has not method name 'valid'" do
    controller = ProductController.new
    controller.instance_variable_set :@product, "string"

    expect(filter.call(ProductController.new, nil, nil, nil)).to be_true
  end

  it "should return true if valid" do
    allow(product).to receive(:valid?).and_return(true)
    expect(filter.call(controller, nil, nil, nil)).to be_true
  end

  it "should return false if invaild" do
    allow(product).to receive(:valid?).and_return(false)
    expect(filter.call(controller, nil, nil, nil)).to be_false
  end

  class ProductController; end
end