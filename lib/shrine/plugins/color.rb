require "colorscore"

class Shrine
  module Plugins
    # text text text
    module Color

      module FileMethods

        def dominant_color
          # Get filename
          if io.respond_to?(:path)
            filename = io.path
          end

          histogram = Colorscore::Histogram.new(filename, 1)
          color = histogram.colors.first
          color && color.html
        end

        # TO DO
        def palette_color

        end

      end

    end

    register_plugin(:color, Color)
  end
end
