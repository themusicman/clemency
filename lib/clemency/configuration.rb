require 'forwardable'

module Clemency
  class Configuration
    extend Forwardable
    def_delegators :@callbacks, :call!
    attr_reader :callbacks
    def initialize
      @callbacks = Callbacks.new
    end
    def before_up(&blk)
      @callbacks.set(:before_up, blk)
    end
    def after_up(&blk)
      @callbacks.set(:after_up, blk)
    end
    def before_down(&blk)
      @callbacks.set(:before_down, blk)
    end
    def after_down(&blk)
      @callbacks.set(:after_down, blk)
    end
  end
end
