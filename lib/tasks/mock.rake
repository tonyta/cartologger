
namespace :mock do
  desc "broadcast points"
  task :broadcast, [:num] => :environment do |t, num:|

    def broadcast(lat, lng)
      ActionCable.server.broadcast("cartolog_channel", lat: lat, lng: lng)
    end

    def iterate(max_iterations)
      lng_enum = (-8..8).map { |i| i * 22.5  }
      lat_enum = (-4..4).map { |i| i * 22.5 }.reverse
      current_count = 0

      lat_enum.cycle do |lat|
        lng_enum.each do |lng|
          sleep 0.01
          broadcast(lat, lng)
          return if (current_count += 1) >= max_iterations
        end
      end
    end

    iterate(Integer(num))
  end

  desc "hit development server with sample log drain requests"
  task :logdrain => :environment do
    sample_log_filename = Rails.root/"lib/sample_request_bodies.txt"
    delimiter = "=============== % ==============="

    headers = {
      "Content-Type"=>"application/logplex-1"
    }
    uri = "http://#{ ENV.fetch("DOMAIN_NAME") { "localhost:3000" } }/logplex"

    log_bodies = File.read(sample_log_filename).split(delimiter)

    log_bodies.each.with_index(1) do |body, i|
      sleep 0.1
      res = HTTP[headers].post(uri, body: body)
      puts "request #{i.to_s.rjust(3, '0')}, status: #{res.status}, runtime: #{res.headers[:x_runtime]}"
    end
  end
end
