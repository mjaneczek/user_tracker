module UserTracker
  class FlashErrorFilter
    def self.call(controller, action_name, event_name, parameters)
      controller.try(:flash).try(:[], :error) == nil
    end
  end
end