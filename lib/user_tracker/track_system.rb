module UserTracker
  class TrackSystem
    def initialize(secret_key)
      ::Analytics.init(secret: secret_key)
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
        traits: { email: user.email, name: user.name }
      )
    end
  end
end