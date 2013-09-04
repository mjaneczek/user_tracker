class ApplicationController
  def self.after_filter(&block)
    @@after_filter_action = block 
  end

  def raise_after_filter(action_name)
    self.stub(:action_name).and_return(action_name)
    self.instance_exec(self, &@@after_filter_action)
  end

  def current_user
    User.instance
  end
end