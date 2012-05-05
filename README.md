# LittleFish

This gem is a little tool for pulling infomation from boston bigpicture, which is a news site with beautiful photos.
The reutrn info format is a data sructure looks like:

    bp: info
      description : text
      image_list : list
        image_url : string
        desc : text
  

## Installation

Add this line to your application's Gemfile:

    gem 'little_fish'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install little_fish

## Usage
1. demo
  little_fish --help

2. add this line in your application
 
```ruby 
require 'little_fish'
fisher = LittleFish::Fisher.new do |f|
  f.last_nth_item = 0 #0 for latest post, and 1 means the last one, 2 means the one before last post, eg.
  f.dumpfile = 'temp.txt'#if not assigned, filename will be named by datetime. if assigned 'no', 'none', or 'false', it wont dump out any file
end
info = fisher.pull
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
