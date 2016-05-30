class CartologChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cartolog_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
