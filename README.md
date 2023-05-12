# Fedex-API

A Ruby gem that provides a simple and flexible way to access the FedEx API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add fedex

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install fedex

## Usage

After instalation now you can use the gem the next way, first require the gem.

```bash
require 'fedex'
```
Then you can just do the following

```bash
Fedex::Rates.get(credentials, rate_params)
```

Where credentials and rate params follows the next structure:

```bash
credentials = {
  "fedex_key" => "",
  "fedex_password" => "",
  "fedex_account_number" => "",
  "fedex_meter_number" => ""
}
```
```bash
rate_params = {
  "address_from" => {
    "street_name" => "",
    "city" => "",
    "state_or_province_code" => "",
    "zip" => "",
    "country" => ""
  },
  "address_to" => {
    "street_name" => "",
    "city" => "",
    "state_or_province_code" => "",
    "zip" => "",
    "country" => ""
  },
  "parcel" => {
    "mass_unit" => "",
    "weight" => "",
    "length" => "",
    "width" => "",
    "height" => "",
    "distance_unit" => ""
  }
}

```

For more details consult [Fedex docs](https://developer.fedex.com/api/en-us/catalog/rate/v1/docs.html)

## Running the Tests

To run the tests for the API, simply run:

```bash
bundle exec rspec
```
or
```bash
rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/CarlosAI/fedex-api](https://github.com/CarlosAI/fedex-api). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/CarlosAI/fedex-api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fedex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CarlosAI/fedex-api/blob/master/CODE_OF_CONDUCT.md).
