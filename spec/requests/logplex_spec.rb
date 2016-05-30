require "rails_helper"

describe LogplexController, type: :request do
  describe "POST" do
    context "when the request body is one line" do
      let(:request_body) do
        <<~REQUEST_BODY
          320 <190>1 2016-05-28T06:50:53.266226+00:00 host app web.1 - [5bfcf090-b554-4319-99a7-1ec1a9a3edb1] [NewRelicPinger/1.0 (676332)] {"method":"HEAD","path":"/monitor","format":"*/*","controller":"monitoring","action":"index","status":200,"duration":20.95,"view":0.19,"db":0.0,"params":{},"host":null,"source":"lograge_event"}
          171 <190>1 2016-05-28T06:50:53.266796+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=7ms timeout=25000ms service=25ms state=completed
          154 <190>1 2016-05-28T06:50:53.328518+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=0ms timeout=25000ms state=ready
          461 <190>1 2016-05-28T06:50:53.345831+00:00 host app web.1 - [5bfcf090-b554-4319-99a7-1ec1a9a3edb1] [Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36] {"method":"GET","path":"/fighter/v1/conversations/available","format":"json","controller":"api/fighter/v1/conversations","action":"index","status":200,"duration":13.46,"view":0.15,"db":0.0,"params":{"format":"json"},"host":null,"source":"lograge_event"}
          171 <190>1 2016-05-28T06:50:53.347064+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=0ms timeout=25000ms service=19ms state=completed
          154 <190>1 2016-05-28T06:50:53.355269+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=4ms timeout=25000ms state=ready
          284 <158>1 2016-05-28T06:50:53.369991+00:00 host heroku router - at=info method=GET path="/fighter/v1/conversations/available" host=app.scrabble-babble.com request_id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=0ms service=20ms status=304 bytes=758
          456 <190>1 2016-05-28T06:50:53.376889+00:00 host app web.1 - [5bfcf090-b554-4319-99a7-1ec1a9a3edb1] [Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36] {"method":"GET","path":"/fighter/v1/fighting_samples","format":"json","controller":"api/fighter/v1/fighting_samples","action":"index","status":200,"duration":16.28,"view":11.38,"db":0.0,"params":{"format":"json"},"host":null,"source":"lograge_event"}
          154 <190>1 2016-05-28T06:50:53.378763+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=5ms timeout=25000ms state=ready
          171 <190>1 2016-05-28T06:50:53.379202+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=4ms timeout=25000ms service=24ms state=completed
          276 <158>1 2016-05-28T06:50:53.383848+00:00 host heroku router - at=info method=GET path="/fighter/v1/fighting_samples" host=app.scrabble-babble.com request_id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=1ms service=29ms status=304 bytes=758
          624 <190>1 2016-05-28T06:50:53.400818+00:00 host app web.1 - [5bfcf090-b554-4319-99a7-1ec1a9a3edb1] [Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36] {"method":"GET","path":"/fighter_profiles/574a7902a6e02a869440c97a","format":"json","controller":"fighter_profiles","action":"show","status":200,"duration":16.21,"view":12.87,"db":0.0,"params":{"authenticity_token":"opensesame","format":"json","from_dashboard":"true","id":"574a7902a6e02a869440c97a"},"host":null,"source":"lograge_event"}
          171 <190>1 2016-05-28T06:50:53.401682+00:00 host app web.1 - source=rack-timeout id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 wait=5ms timeout=25000ms service=23ms state=completed
        REQUEST_BODY
      end

      it "returns http success" do
        post logplex_path,
          params: request_body,
          headers: { "Content-Type" => "application/logplex-1" }

        expect(ActiveJob::Base.queue_adapter.enqueued_jobs).to eq [
          { job: CartologBroadcastJob, queue: "default",
            args: [%{284 <158>1 2016-05-28T06:50:53.369991+00:00 host heroku router - at=info method=GET path="/fighter/v1/conversations/available" host=app.scrabble-babble.com request_id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=0ms service=20ms status=304 bytes=758}] },
          { job: CartologBroadcastJob, queue: "default",
            args: [%{276 <158>1 2016-05-28T06:50:53.383848+00:00 host heroku router - at=info method=GET path="/fighter/v1/fighting_samples" host=app.scrabble-babble.com request_id=5bfcf090-b554-4319-99a7-1ec1a9a3edb1 fwd="188.14.225.207,54.161.112.48" dyno=web.1 connect=1ms service=29ms status=304 bytes=758}] },
        ]

        expect(response).to have_http_status :success
      end
    end
  end
end

