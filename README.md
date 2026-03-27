# Lever
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FGrayscale-Labs%2Flever.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FGrayscale-Labs%2Flever?ref=badge_shield)


Unoffical gem to access the [Lever](https://www.lever.co/) v1 API.

From Lever:
> The Lever API lets you build a variety of applications and scripts to create candidates, integrate Lever with other business platforms (HRIS, HRMS, etc.), and show Lever data outside of the app.

NOTE: This is NOT for the Postings API

From Lever:
> Hoping to build an integration with your public job site? You're probably looking for the Postings API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lever'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lever

## Usage

```ruby
token = '1234'
client = Lever::Client.new(token)
```

if you're using a Lever sandbox, specify the sandbox option (uses a different URL)

```ruby
client = Lever::Client.new(token, { sandbox: true })
```

then, use the resource name as a method, and supply the ID to get a singular object.

```ruby
client.opportunities # list opportunities
client.opportunities(id: opportunity_id) # single opportunity
```

supported resources:
- Postings (`Lever::Posting`)
- Opportunities (`Lever::Opportunity`)
- Users (`Lever::User`)

additionally supported objects:
- Applications (expanded via Opportunities resource) (`Lever::Application`)

Error handling can be done via `on_error`

```ruby
client.opportunities(id: opportunity_id, on_error: ->(response) { puts response }) # response is the HTTParty response
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lever. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FGrayscale-Labs%2Flever.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2FGrayscale-Labs%2Flever?ref=badge_large)

## Code of Conduct

Everyone interacting in the Lever project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lever/blob/master/CODE_OF_CONDUCT.md).