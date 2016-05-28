class GeoLogBroadcastJob < ActiveJob::Base
  queue_as :default

  def perform(line)
    ip = RouterLogLine.new(line).ip_address
    location = IPLocator.new(ip)
  end
end
