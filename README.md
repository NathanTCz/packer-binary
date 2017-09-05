[![Gem Version](https://badge.fury.io/rb/packer-binary.svg)](https://badge.fury.io/rb/packer-binary)
[![Build Status](https://travis-ci.org/NathanTCz/packer-binary.svg?branch=master)](https://travis-ci.org/NathanTCz/packer-binary)
[![Coverage Status](https://coveralls.io/repos/github/NathanTCz/packer-binary/badge.svg?branch=master)](https://coveralls.io/github/NathanTCz/packer-binary?branch=master)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/packer-binary)

# Packer::Binary

A gem to install and interface with HashiCorp's Packer utility

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'packer-binary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install packer-binary

## Usage
You need to specify which version of [HashiCorp Packer](https://www.packer.io/downloads.html) to use. You can also specify where to save the binary file.

```ruby
require 'packer/binary'

Packer::Binary.configure do |config|
  config.version = '1.0.4'
  config.download_path = '/tmp'
end
```

### Dynamic Methods
The {Packer::Binary} module will automagically map method calls to `packer` commands. This serves to better support future versions of `packer` and potentially new commands. For example, the equivalent of `packer build test.json` in Ruby:

```ruby
Packer::Binary.build('test.json')
```

If you call a method not supported by the `packer` binary, you will get a {Packer::Binary::Command::CommandFailure} exception.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nathantcz/packer-binary.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
