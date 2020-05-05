require 'rails/generators/base'

module Clemency
    class InstallGenerator < Rails::Generators::Base

      desc "Installs Clemency's configuration file"
      def create_release_file
        config_file = %Q(#add gem "slack-notifier" to your Gemfile
#notifier = Slack::Notifier.new "WEBHOOK_URL"
Clemency.configure do
  before_up do |release|
    #execute code before every migration
  end
  after_up do |release|
    #execute code after every migration
    #message = release.to_markdown
    #notifier.post(text: message)
  end
  before_down do |release|
    #execute code before every rollback
  end
  after_down do |release|
    #execute code after every rollback
  end
end)
        create_file "config/clemency.rb", config_file
      end
    end
end
