require_relative 'boot'

require "active_job/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module GeoLogger
  class Application < Rails::Application
  end
end
