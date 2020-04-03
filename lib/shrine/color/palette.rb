module ShrineColor
  class Palette < Array
    DEFAULT = %w[
      660000
      990000
      cc0000
      cc3333
      ea4c88
      993399
      663399
      333399
      0066cc
      0099cc
      66cccc
      77cc33
      669900
      336600
      666600
      999900
      cccc33
      ffff00
      ffcc33
      ff9900
      ff6600
      cc6633
      996633
      663300
      000000
      999999
      cccccc
      ffffff
    ]

    def self.default
      from_hex DEFAULT
    end

    def self.from_hex(hex_values)
      new hex_values.map { |hex| Color::RGB.from_html(hex) }
    end

    def scores(histogram_scores, distance_threshold = 0.275)
      scores =
        map do |palette_color|
          score = 0

          histogram_scores.each_with_index do |item, index|
            color_score, color = *item

            color =
              color.to_hsl.tap { |c| c.s = 0.05 + c.s * (4 - c.l * 2.5) }.to_rgb

            if (distance = Metrics.distance(palette_color, color)) <
                 distance_threshold
              distance_penalty = (1 - distance)**4
              score += color_score * distance_penalty
            end
          end

          [score, palette_color]
        end

      scores.reject { |score, color| score <= 0.05 }.sort_by do |score, color|
        score
      end.reverse
    end

    # From a large palette, collects scores and reduces them based on
    # the distance threshold (which can be varied to find a specific number of colors)
    def collect_scores(
      distance_threshold = 0.275, min_colors = 3, max_colors = 7
    )
      def generate_scores(threshold)
        @res = [[1, self[0]]]
        @pivot = self[0]
        self.each do |color|
          if (Metrics.distance(@pivot, color)) > threshold
            @res << [1, color]
            @pivot = color
          else
            @res.last[0] += 1
          end
        end
        @res
      end

      @results = generate_scores(distance_threshold)

      if @results.length <= min_colors && distance_threshold > 0.05
        self.collect_scores((distance_threshold - 0.05))
      elsif @results.length > max_colors && distance_threshold < 0.5
        self.collect_scores((distance_threshold + 0.05))
      else
        return @results
      end
    end
  end
end
