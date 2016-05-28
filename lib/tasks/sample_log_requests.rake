desc "hit development server with sample log drain requests"
task mock_log_drain: :environment do
  sample_log_filename = Rails.root/"lib/sample_request_bodies.txt"
  delimiter = "=============== % ==============="

  headers = {
    "Content-Type"=>"application/logplex-1"
  }
  uri = "http://localhost:3000/logplex"

  File.read(sample_log_filename).split(delimiter).each do |body|
    sleep 0.5
    res = HTTP[headers].post(uri, body: body)
    puts res.status
  end
end
