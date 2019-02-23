require "pry"

RSpec.describe Clemency::Callbacks do


  describe "#set & #get" do

    it "should store a callback for a key" do
      callbacks = Clemency::Callbacks.new
      callbacks.set(:test, Proc.new {})
      expect(callbacks.get(:test)).to respond_to(:call)
    end

  end

  describe "#call!" do

    it "should retrieve and call call on a callback" do
      block = double("callback")
      expect(block).to receive(:call)
      callbacks = Clemency::Callbacks.new
      callbacks.set(:test, block)
      callbacks.call!(:test)
    end

    it "should retrieve and call call on a callback with args" do
      a = 1
      b = 2
      block = double("callback")
      expect(block).to receive(:call).with(a, b)
      callbacks = Clemency::Callbacks.new
      callbacks.set(:test, block)
      callbacks.call!(:test, a, b)
    end

  end




end
