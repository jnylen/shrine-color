require 'spec_helper'

describe Shrine::Plugins::Color do
  before do
    @uploader = uploader { plugin :add_metadata
                           plugin :color }
  end

  describe ":dominant_color" do
    it "extracts dominant_color from files via add_metadata" do
      @uploader.class.add_metadata(:dominant_color) { |io, context| dominant_color(io) }
      uploaded_file = @uploader.upload(File.open("spec/fixtures/bora.jpg"))
      expect(uploaded_file.metadata.fetch("dominant_color")).to eq("#48839f")
    end
  end

  describe ":palette_color" do
    it "extracts palette_color from files with default hexes via add_metadata" do
      @uploader.class.add_metadata(:palette_color) { |io, context| palette_color(io) }
      uploaded_file = @uploader.upload(File.open("spec/fixtures/bora.jpg"))
      expect(uploaded_file.metadata.fetch("palette_color")).to eq("#333399")
    end

    it "extracts palette_color from files with custom hexes via add_metadata" do
      @uploader.class.add_metadata(:palette_color) { |io, context| palette_color(io, ['ff0000', '00ff00', '0000ff']) }
      uploaded_file = @uploader.upload(File.open("spec/fixtures/bora.jpg"))
      expect(uploaded_file.metadata.fetch("palette_color")).to eq("#0000ff")
    end
  end

end
