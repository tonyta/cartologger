desc "hit development server with sample log drain requests"
task mock_log_drain: :environment do
  sample_log_filename = Rails.root/"lib/sample_request_bodies.txt"
  delimiter = "=============== % ==============="

  headers = {
    "Content-Type"=>"application/logplex-1"
  }
  uri = "http://geo.tonyta.com/logplex"

  log_bodies = File.read(sample_log_filename).split(delimiter)

  log_bodies.each.with_index(1) do |body, i|
    sleep 0.1
    res = HTTP[headers].post(uri, body: body)
    puts "request #{i.to_s.rjust(3, '0')}, status: #{res.status}, runtime: #{res.headers[:x_runtime]}"
  end
end
