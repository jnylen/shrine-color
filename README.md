Shrine Color
=================

Get the dominant color of an image using colorscore (updated version by me). This can be used as a background color while an image is loading or search by color.

This is based on carrierwave-color by Sunny Ripert (sunny).

Requirements
------------

This gem requires imagemagick (convert) and grabs colors via a command line.
So mini_magick, etc. isn't required.


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem "shrine-color"
```

And then call:

```sh
$ bundle
```

Add the plugin to your uploader
--------------------------------

In your uploader, include the module and call the processor:

```ruby
class AlbumUploader < Shrine
  plugin :color
end
```

You can now use <image>.dominant_color to grab the dominant color.
