# Itamae::Plugin::Resource::Mysql

This gem enables you to create database, user and drop them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-resource-mysql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-resource-mysql

## Usage

```ruby
mysql "create user" do
    database "hoge"
    loginuser "root"
    loginpass node['yourjson']['loginpass']
    host "localhost"
    port "3306"

    username "hoge"
    password "hoge"
    user_hosts ["localhost", "%"]

    with_grants true
    user_priviliges ["all"]
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/itamae-plugin-resource-mysql/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
