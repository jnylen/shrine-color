require 'spec_helper'

describe Shrine::Plugins::Color do
  before do
    @attacher = attacher { plugin :color }
    @user = @attacher.record
  end

  describe ":dominant_color" do
    it "extracts dominant_color from files" do
      @user.avatar = File.open("spec/fixtures/bora.jpg")
      expect(@user.avatar.dominant_color).to eq("#48839f")
    end
  end

  describe ":palette_color" do
    it "extracts palette_color from files with default hexes" do
      @user.avatar = File.open("spec/fixtures/bora.jpg")
      expect(@user.avatar.palette_color).to eq("#333399")
    end

    it "extracts palette_color from files with custom hexes" do
      @user.avatar = File.open("spec/fixtures/bora.jpg")
      expect(@user.avatar.palette_color(["#ffffff"])).to eq("#ffffff")
    end
  end
end
