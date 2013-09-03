class ApplicationController
  def self.after_filter(&block)
    @@after_filter_action = block 
  end

  def raise_after_filter(action_name)
    stub_controller = stub("controller")
    stub_controller.stub(:action_name).and_return(action_name)
    self.instance_exec(stub_controller, &@@after_filter_action)
  end
end