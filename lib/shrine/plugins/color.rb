require "colorscore"

class Shrine
  module Plugins
    # text text text
    module Color
      def self.load_dependencies(uploader, *)
        uploader.plugin :add_metadata
      end

      module InstanceMethods
        DEFAULT_PALETTE_HEXES = ["660000", "990000", "cc0000", "cc3333", "ea4c88", "993399",
                   "663399", "333399", "0066cc", "0099cc", "66cccc", "77cc33",
                   "669900", "336600", "666600", "999900", "cccc33", "ffff00",
                   "ffcc33", "ff9900", "ff6600", "cc6633", "996633", "663300",
                   "000000", "999999", "cccccc", "ffffff"]

        # Returns the most dominant color in HEX in an image.
        def dominant_color(io_path)
          histogram = Colorscore::Histogram.new(io_path, :colors => 1)
          color = histogram.colors.first
          color && color.html # html = hex
        end

        # Matches the dominant color to the closest color in the array provided
        def palette_color(io_path, color_count = 1, palette_hexes = DEFAULT_PALETTE_HEXES)
          histogram = Colorscore::Histogram.new(io_path)
          palette = Colorscore::Palette.from_hex(palette_hexes)

          histogram_scores = histogram.scores
          return nil if histogram_scores.first.last.nil?

          scores = palette.scores(histogram_scores, 1)
          scores.first(color_count).map { |_score, color| color.html}
        end

      end

    end

    register_plugin(:color, Color)
  end
end
