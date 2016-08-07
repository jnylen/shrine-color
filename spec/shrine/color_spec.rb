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
end
