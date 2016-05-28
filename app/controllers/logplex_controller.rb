class LogplexController < ApplicationController
  ROUTER_RE = /heroku router/

  def create
    router_logs = request.body.each_line do |line|
      GeoLogBroadcastJob.perform_later(line.chomp) if line =~ ROUTER_RE
    end

    head :created
  end
end
