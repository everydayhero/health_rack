# HealthRack

Easily add a health status page to your rack-compatible application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'health_rack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install health_rack

## Usage

Add a class containing the various checks you would like to perform.

```ruby
class Health < HealthRack::Base
  check "Database" do
    # Add code to check connectivity to database
  end

  check "Lemons" do
    true
  end
end

run Health.new
```

Then mount the health check in your routes

```ruby
mount HealthStatus.new, at: '/health'
```

Visiting that path in a browser will perform the health check and present the output.

There is also the option of adding `.json` to the path to generate json output.

## Contributing

1. Fork it ( https://github.com/everydayhero/health_rack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
