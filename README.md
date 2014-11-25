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

```ruby
use HealthRack, path: "/status" do
  check "Database" do
    # Add code to check connectivity to database
  end

  check "Lemons" do
    true
  end
end
```

Then simply visit the page (ie. `/status`) to view the output. By default the output will be in HTML but you can add the `.json` suffix to get a JSON output instead.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/health_rack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
