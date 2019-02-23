require 'forwardable'

module Clemency

  class Release
    extend Forwardable

    def_delegators :@callbacks, :call!

    attr_reader :callbacks

    def initialize
      @config = {}
      @changelog = Changelog.new
      @callbacks = Callbacks.new
    end

    def set(key, value)
      @config[key] = value
    end

    def get(key, default = nil)
      @config.fetch(key, default)
    end

    def changelog(&blk)
      if block_given?
        @changelog.instance_eval(&blk)
      else
        @changelog
      end
    end

    def up(&blk)
      @callbacks.set(:up, blk)
    end

    def down(&blk)
      @callbacks.set(:down, blk)
    end

    def to_markdown
      %Q(##[#{get(:version)}] - #{Time.now.strftime("%D")}

#{@changelog.to_markdown}
      )
    end

  end

end
