class GeoLogBroadcastJob < ActiveJob::Base
  queue_as :default

  def perform(line)
  end
end
