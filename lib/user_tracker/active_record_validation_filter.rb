module UserTracker
  require 'active_support/inflector'

  class ActiveRecordValidationFilter
    def self.call(controller, action_name, event_name, parameters)
      model_name = "@#{controller.class.name.sub("Controller", "").singularize.underscore}"
      model = controller.instance_eval(model_name)
      return true unless model

      model.try(:valid?).nil? || model.try(:valid?)
    end
  end
end