module Clemency

  class Callbacks

    def initialize
      @callbacks = {}
    end

    def call!(key, *args)
      get(key).call(*args)
    end

    def get(key)
      @callbacks.fetch(key, Proc.new {})
    end

    def set(key, callback)
      @callbacks[key] = callback
    end

  end

end
