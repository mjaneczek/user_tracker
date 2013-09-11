module UserTracker
  class AnalyticsTrackSystem
    attr_accessor :user_additional_parameters

    def initialize(secret_key)
      ::Analytics.init(secret: secret_key)
      @user_additional_parameters = -> (user) { { email: user.email} }
    end

    def track(event_name, user, parameters)
      identity_user(user)

      ::Analytics.track(
        user_id: user.id,
        event: event_name,
        properties: parameters
      )
    end

    def identity_user(user)
      ::Analytics.identify(
        user_id: user.id,
        traits: user_additional_parameters.call(user)
      )
    end
  end
end