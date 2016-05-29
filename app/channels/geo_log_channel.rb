class GeoLogChannel < ApplicationCable::Channel
  def subscribed
    stream_from "geo_log_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
