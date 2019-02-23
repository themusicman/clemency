require "clemency/version"
require "clemency/callbacks"
require "clemency/configuration"
require "clemency/changelog"
require "clemency/release"
require 'clemency/railtie' if defined?(Rails)

module Clemency

  class Error < StandardError; end

  @releases = {}
  @config = Configuration.new

  def self.config
    @config
  end

  def self.releases
    @releases
  end

  def self.define_release(&blk)
      release = Release.new
      release.instance_eval(&blk)
      Clemency.releases[release.get(:version)] = release
      release
  end

  def self.load_config
    load "#{Rails.root}/config/clemency.rb"
  end

  def self.latest_release
    latest_verion = @releases.keys.sort{|a, b| Gem::Version.new(a) <=>  Gem::Version.new(b) }.last
    puts latest_verion
    @releases.fetch(latest_verion, nil)
  end

  def self.load_release_files
    Dir.glob("#{Rails.root}/releases/*.rb").each { |f| load f }
  end

  def self.configure(&blk)
    @config.instance_eval(&blk)
  end

  def self.migrate!(version)
    puts "Clemency is migrating release #{version}"
    release = @releases.fetch(version, nil)
    if release.nil?
      puts "We could not find release #{version}"
      return
    end
    @config.call!(:before_up, release)
    release.call!(:up, release)
    @config.call!(:after_up, release)
  end

  def self.rollback!(version)
    puts "Clemency is migrating release #{version}"
    release = @releases.fetch(version, nil)
    if release.nil?
      puts "We could not find release #{version}"
      return
    end
    @config.call!(:before_down, release)
    release.call!(:down, release)
    @config.call!(:after_down, release)
  end

  def self.to_markdown
      @releases.map { |release| release.to_markdown }.join("\n\n")
  end

end
