require "clemency"

namespace :clemency do

  # TODO: Refactor the migrate and rollback - loads of duplication...

  desc "Migrates a specific release version"
  task :migrate, [:version] => [:environment] do |t, args|
    version = args[:version]
    if version.nil?
      version = File.read("#{Rails.root}/.version").to_s.strip
    end
    Clemency.load_config
    Clemency.load_release_files
    Clemency.migrate!(version)
  end

  desc "Rollback a specific release version"
  task :rollback, [:version] => [:environment] do |t, args|
    version = args[:version]
    if version.nil?
      version = File.read("#{Rails.root}/.version").to_s.strip
    end
    Clemency.load_config
    Clemency.load_release_files
    Clemency.rollback!(version)
  end

  desc "Generate changelog for a release"
  task :changelog, [:version] => [:environment] do |t, args|
    version = args[:version]
    if version.nil?
      version = File.read("#{Rails.root}/.version").to_s.strip
    end
    puts "Clemency is generating a changelog for release #{version}"
    Clemency.load_release_files
    release = Clemency.releases.fetch(version, nil)
    if release.nil?
      puts "We could not find release #{version}"
      next
    end
    puts release.to_markdown
  end




end
