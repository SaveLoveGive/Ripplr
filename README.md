Ripplr
======
Ripplr is a library to assist with indexing your Ripple models in Riak. THe library currently is working to support Riak's Solr
capabilities. Will evolve to support 2i as well.

Dependencies
============
Ripplr is dependant on `ripple` and `riak-client`. Ripplr is available on RubyGems and can be installed by adding `ripplr` to your Gemfile.

It's simple to use!
===================
Once you've installed the Ripplr gem using bundler you can begin setting up your Ripple Documents to be queryable.

To make a document queryable, `include Ripplr::Queryable` and then describe which fields you would like to be queryable by using a `queryable` block.

For example you can define a class as queryable like this:
```ruby
class Wod
  include Ripple::Document
  include Ripplr::Queryable
  property :description, String
  property :notes, String
  property :performed_at, Time
  
  queryable do
    text :description
    text :notes
    time :performed_at
  end
end
```
And then create, index and search for your documents like so:
```ruby
todays_wod = Wod.create :description => 'Lawnmower 8x35lbs. Sqt Jumps 10x. Lunge Twist 20x10lbs ...', :performed_at = Time.now 
todays_wod.index #add the index for your document
Wod.search(:description, "jumps") # Search WODs for descriptions that contain jump, returns an array of matching WODs
```

