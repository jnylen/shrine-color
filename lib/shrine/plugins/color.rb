require "colorscore"

class Shrine
  module Plugins
    # text text text
    module Color

      module FileMethods
        DEFAULT_PALETTE_HEXES = ["660000", "990000", "cc0000", "cc3333", "ea4c88", "993399",
                   "663399", "333399", "0066cc", "0099cc", "66cccc", "77cc33",
                   "669900", "336600", "666600", "999900", "cccc33", "ffff00",
                   "ffcc33", "ff9900", "ff6600", "cc6633", "996633", "663300",
                   "000000", "999999", "cccccc", "ffffff"]

        def dominant_color
          # Get filename
          if io.respond_to?(:path)
            filename = io.path
          end

          histogram = Colorscore::Histogram.new(filename, :colors => 1)
          color = histogram.colors.first
          color && color.html # html = hex
        end

        # TO DO
        def palette_color(palette_hexes = DEFAULT_PALETTE_HEXES)
          # Get filename
          if io.respond_to?(:path)
            filename = io.path
          end

          histogram = Colorscore::Histogram.new(filename)
          palette = Colorscore::Palette.from_hex(palette_hexes)

          histogram_scores = histogram.scores
          return nil if histogram_scores.first.last.nil?

          scores = palette.scores(histogram_scores, 1)
          _score, color = scores.first
          color.html
        end

      end

    end

    register_plugin(:color, Color)
  end
end
