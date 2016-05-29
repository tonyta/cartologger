class GeoLogBroadcastJob < ApplicationJob
  queue_as :default

  def perform(line)
    log_line = RouterLogLine.new(line)
    return unless log_line.status_success?
    location = IPLocator.new(log_line.ip_address)
    ActionCable.server.broadcast("geo_log_channel", message: location.country_name)
  end
end
