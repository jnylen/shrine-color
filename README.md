# Shrine Color

Get the dominant color of an image using colorscore (updated version by me). This can be used as a background color while an image is loading or search by color.

This is based on carrierwave-color by Sunny Ripert (sunny).

**NOTE: The palettes/dominiant_color grabbed from images may differ between imagemagick versions.**

**Current version of imagemagick the test runs towards: 7.0.8-68**

## Requirements

This gem requires imagemagick (convert) and grabs colors via a command line.
So mini_magick, etc. isn't required.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "shrine-color"
```

And then call:

```sh
$ bundle
```

## Add the plugin to your uploader

In your uploader, include the module and call the processor:

```ruby
class ImageUploader < Shrine
  # plugin add_metadata should be loaded automagically.
  # otherwise add it here
  plugin :color

  # dominant color
  add_metadata :dominant_color do |io, context|
    dominant_color(io.path)
  end

  # palette color with version, color count and own array of colors.
  add_metadata :palette_color do |io, context|
    if context[:version] == :small
      palette_color(io.path, 3, ['ff0000', '00ff00', '0000ff'])
    end
  end
end
```

You can now use the code below to get a color:

```ruby
## Dominant color
photo.image[:small].metadata["dominant_color"]
# or
photo.image[:small].dominant_color
```
