require "spec_helper"
require_relative APP_ROOT/"models/router_log_line.rb"

describe RouterLogLine do
  let(:line) do
    <<~HERE
      439 <158>1 2016-05-28T09:45:04.654353+00:00 host heroku router - at=info method=GET path="/fighter_profiles/574a7902a6e02a869440c97a?authenticity_token=opensesame&format=json&from_dashboard=true" host=app.scrabble-babble.com request_id=6ba37111-344f-2a72-8353-0d0bdc5aba64 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=4ms service=53ms status=200 bytes=56928
    HERE
  end

  subject { described_class.new(line) }

  it { should be_status_ok }
  it { should be_status_success }

  it "should capture the first ip address" do
    expect(subject.ip_address).to eq "188.14.225.207"
  end

  context "when status is successful but not 200" do
    let(:line) do
      <<~HERE
        291 <158>1 2016-05-28T09:45:04.222762+00:00 host heroku router - at=info method=GET path="/fighter/v1/phone_calls?status=unscheduled" host=app.scrabble-babble.com request_id=e7f381bf-f43b-2b69-a953-fd2edc5a7a63 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=0ms service=15ms status=304 bytes=758
      HERE
    end

    it { should_not be_status_ok }
    it { should be_status_success }
  end

  context "when status is not successful" do
    let(:line) do
      <<~HERE
        251 <158>1 2016-05-28T23:08:28.400993+00:00 host heroku router - at=info method=GET path="/madkings/sign_up" host=app.scrabble-babble.com request_id=05e33df7-f17a-4a6d-a9c2-d155a36203a2 fwd="50.0.205.108" dyno=web.1 connect=1ms service=584ms status=500 bytes=1732
      HERE
    end

    it { should_not be_status_ok }
    it { should_not be_status_success }
  end
end
