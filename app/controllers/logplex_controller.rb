class LogplexController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  ROUTER_RE = /heroku router/

  def create
    request.body&.each_line do |line|
      CartologBroadcastJob.perform_later(line.chomp) if line =~ ROUTER_RE
    end

    head :created
  end
end
