# MaxValue

It is Enumerable extension.

It makes easier to access first elements' attribute after max\_by or min\_by

## Installation

Add this line to your application's Gemfile:

    gem 'max_value', github: 'joker1007/max_value'

And then execute:

    $ bundle

## Usage

```ruby
array = [
  Hashie::Mash.new({id: 1, name: "name_c"}),
  Hashie::Mash.new({id: 2, name: "name_a"}),
  Hashie::Mash.new({id: 3, name: "name_z"}),
  Hashie::Mash.new({id: 4, name: "name_b"}),
]

hash_array = [
  {id: 1, name: "name_c"},
  {id: 2, name: "name_a"},
  {id: 3, name: "name_z"},
  {id: 4, name: "name_b"},
]

# before (so bad!!)
array.max_by(&:id).id               # => 4
hash_array.max_by {|h| h[:id]}[:id] # => 4

# after (so cool!!)
array.max_value(:id)      # => 4
hash_array.max_value(:id) # => 4

# more example
array.min_value(:id, &:name)             # => 2 min_by(&:name) and access to id
hash_array.min_value(:id) {|h| h[:name]} # => 2
array.sort_value(:id, &:name)            # => [2, 4, 1, 3] sort_by(&:name) and map by id
array.lazy.sort_value(:id, &:name)       # => Enumerator::Lazy sort_by(&:name).lazy.map(&:id)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
