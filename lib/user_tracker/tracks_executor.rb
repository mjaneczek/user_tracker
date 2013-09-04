module UserTracker
  class TracksExecutor
    attr_accessor :track_system
    attr_accessor :filters

    def initialize
      @filters = []
      hook_application_controller_after_filter_method
      register_default_filters
    end

    def after_controller_action(controller, action_name)
      return unless source 
      
      source.each do |item|
        if action_name == item[:action_name] && controller.class == item[:subject]
          next unless filters.all?{|filter| filter.call(controller, action_name, item[:event_name], get_params(item, controller)) }
          track_system.track(item[:event_name], controller.current_user, get_params(item, controller) )
        end
      end
    end

    def source
      @tracking_action ||= ::TrackingActions.new
      @tracking_action.tracks
    end

    private

      def register_default_filters
        @filters.push(UserTracker::ActiveRecordValidationFilter)
      end

      def hook_application_controller_after_filter_method
        class_type = self

        ApplicationController.class_eval do
          after_filter { |controller| class_type.after_controller_action(controller, controller.action_name.to_sym) }
        end
      end

      def get_params(item, subject)
        item[:block] && subject.instance_eval(&item[:block])
      end
  end
end