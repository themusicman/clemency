require "pry"

RSpec.describe Clemency::Release do

  it "allow you to set a version number" do
      release = Clemency::Release.new
      release.set(:version, '1.0.0')
      expect(release.get(:version)).to eq('1.0.0')
  end

  describe "#changelog" do

    it "allows you to set changelog items that are fixed" do
      release = Clemency::Release.new
      release.changelog do
        fixed "Test"
      end
      expect(release.changelog.items.fetch(:fixed).first).to eq("Test")
    end

    it "allows you to set changelog items that are changed" do
      release = Clemency::Release.new
      release.changelog do
        changed "Test"
      end
      expect(release.changelog.items.fetch(:changed).first).to eq("Test")
    end

    it "allows you to set changelog items that are added" do
      release = Clemency::Release.new
      release.changelog do
        added "Test"
      end
      expect(release.changelog.items.fetch(:added).first).to eq("Test")
    end

  end


  describe "#down" do

    it "should call the down callback" do

      block = double("callback")
      expect(block).to receive(:call)

      release = Clemency::Release.new
      release.down do
        block.call
      end

      release.call!(:down, release)

    end

  end


  describe "#up" do

    it "should call the up callback" do

      block = double("callback")
      expect(block).to receive(:call)

      release = Clemency::Release.new
      release.up do
        block.call
      end

      release.call!(:up, release)

    end

  end

  describe ".to_markdown" do
    it "produces release notes in Markdown" do
      release = Clemency.define_release do
        set :version, '1.0.0'
        changelog do
          fixed "Bug in parser"
          added "New feature"
          changed "User sign-up"
        end
      end
      markdown = release.to_markdown
      expect(markdown).to match(/[1.0.0]/)
      expect(markdown).to match(/ADDED/)
      expect(markdown).to match(/CHANGED/)
      expect(markdown).to match(/FIXED/)
    end
  end

end
