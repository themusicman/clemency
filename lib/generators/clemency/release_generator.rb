require 'rails/generators/base'

module Clemency
    class ReleaseGenerator < Rails::Generators::Base
      argument :version, required: true

      desc "Creates a new release file"
      def create_release_file
        release_file = %Q(Clemency.define_release do
  set :version, "#{version}"
  changelog do
    #added "Added changelog item here..."
    #changed "Changed changelog item here..."
    #fixed "Fixed changelog item here..."
  end
  up do |release|
    #perform release migration work here
  end
  down do |release|
    #perform release rollback work here
  end
end)
        create_file "releases/#{version}_release.rb", release_file
        create_file ".version", "#{version}"
      end
    end
end
