# Zotero

Provide easy Ruby access to Zotero, for e.g. generating online bibliographies
and reading lists.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zotero'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zotero

## Usage

First, go find out your [Zoetero user ID](https://www.zotero.org/settings/keys).

Then [create a private key](https://www.zotero.org/settings/keys/new) to access
your data via the Zotero API.

Now you can access your data using this Ruby gem. For example:

```
library = Zotero::Library.new ZOTERO_USER_ID, ZOTERO_KEY
library.collections                     # Get all your top-level collections
collection = library.collections.first 
collection.entries                      # Get all the entries in a collection
collection.collections                  # Get sub-collections
collection.entries.first.title          # Get the title of an entry
collection.entries.first.kind           # e.g. 'journal_article' / 'book'
collection.entries.first.authors
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/zotero.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

