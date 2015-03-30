# Afterbuy

This is a wrapper for the afterbuy API.
API's definition is documented here: http://xmldoku.afterbuy.de/dokued/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'afterbuy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install afterbuy

## Usage

    Afterbuy.configure do |config|
      config.partner_id = 'valid_partner_id'
      config.partner_password = 'valid_partner_password'
      config.user_id = 'valid_user_id'
      config.user_password = 'valid_user_password'
    end

    afterbuy = Afterbuy::API.new
    afterbuy.call('GetAfterbuyTime')

## Contributing

1. Fork it ( https://github.com/[my-github-username]/afterbuy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
