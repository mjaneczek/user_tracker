# UserTracker

Track user's actions like profile update, product order and everything else you need!
Gem provides simple configuration separated from controller's code. 
Don't repeat yourself - just one configuration file - no duplications across controllers' actions.

## Installation

Add this lines to your application's Gemfile:
```rb
gem 'analytics-ruby'
gem 'user_tracker', github: 'mjaneczek/user_tracker'
```

And then execute:

    $ bundle

## Getting Started

UserTracker expects a ```current_user``` method to exist in the controller. 
First, set up some authentication (such as [Authlogic](https://github.com/binarylogic/authlogic) 
or [Devise](https://github.com/plataformatec/devise).

### 1. Initialization

Create new file in ```/config/initializers``` catalog (eg. ```user_tracker.rb```) and add this lines:
```rb
tracker = UserTracker::TracksExecutor.new
tracker.track_system = UserTracker::AnalyticsTrackSystem.new("your_sercret_code")
```

UserTracker provides tracking system called AnalyticsTrackSystem that depends on [analytics-ruby](https://github.com/segmentio/analytics-ruby) but you can easily change it to your own.

### 2. Configuration

Just add a new class in ```app/models/tracking_actions.rb``` with the folowing contents:
```rb
class TrackingActions
  include UserTracker::TrackingActions

  def initialize
    track :create, ProductController, "Product created!"
  end
end
```

Now every time when user creates products tracking system sends request to analytics with specific event name.

### 3. Additional parameters

You can pass to tracking system additional parameters via adding a block to method.
```rb
track :create, ProductController, "Product created!" { "Category": "Computers" }
```

Block is executing in the context of controller so you can use instance variables eg:
```rb
track :create, ProductController, "Product created!" { @product.attributes }
```
### 4. Filters

Default UserTracker has one filter that cancels tracking if instance variable 
(with the same name like controller, eg. ```@product``` for ```ProductsController```) has validation status set to false.
```rb
class ProductController
  def create
    @product.valid? # if it is false after create action - skip
  end
end
```

To declare own filter (``/config/initializers/user_tracker.rb```):
```rb
tracker.filters.push(Proc.new do |controller, action_name, event_name, parameters|
  return true unless controller.class == ProductsController
  parameters["Category"] == "Computers"
end
```

This filter skips all actions of ProductsController if category is other than "Computers". 
Instead of Proc you can use class with class method called "call" with all 4 parameters (like [this](https://github.com/mjaneczek/user_tracker/blob/master/lib/user_tracker/active_record_validation_filter.rb)).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

##### Inspired by [Ryan Bates - CanCan](https://github.com/ryanb/cancan)