module UserTracker
  class TracksExecutor
    class << self
      attr_accessor :track_system

      def initialize
        class_type = self

        ApplicationController.class_eval do
          after_filter { |controller| class_type.after_controller_action(controller.action_name) }
        end
      end

      def after_controller_action(action_name)
        return unless source 

        source.each do |item|
          if action_name.to_sym == item[:action_name]
            track_system.track(item[:event_name], nil)
          end
        end
      end

      def source
        @@tracking_action ||= ::TrackingActions.new
        @@tracking_action.tracks
      end
    end
  end
end