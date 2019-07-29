# Clemency

Gem that allows you to describe and manage your releases.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clemency'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clemency

## Usage

Installs the configuration file:

    $ rails g clemency:install

Create a new release (Generates a new release file in RAILS_ROOT/releases folder):

    $ rails g clemency:release 1.1.0

Migrate to a specific release:

    $ rails clemency:migrate -> calls the up callback on the current release as defined in .version
    $ rails clemency:migrate[1.1.0] -> calls the up callback on the 1.1.0 release
    $ [NOT IMPLEMENTED] rails clemency:migrate[1.0.0-1.1.0] -> calls the up callback on all releases between 1.0.0 and 1.1.0

Rollback to a specific release:

    $ rails clemency:rollback -> calls the down callback on the current release as defined in .version
    $ rails clemency:rollback[1.1.0] -> calls the down callback on the 1.1.0 release
    $ [NOT IMPLEMENTED] rails clemency:rollback[1.1.0-1.0.0] -> calls the down callback on all releases between 1.1.0 and 1.0.0

Generate a changelog for a specific release:

    $ rails clemency:changelog -> generates a changelog the current release as defined in .version
    $ rails clemency:changelog[1.1.0] -> generates a changelog for the 1.1.0 release
    $ [NOT IMPLEMENTED] rails clemency:changelog[1.1.0-1.0.0] -> generates a changelog for all releases between 1.1.0 and 1.0.0

## TODO

- add more specs
- implement rake tasks that execute a series of release tasks

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leftplusrightllc/clemency.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
