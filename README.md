# Cartologger
[**Mapping Live, Realtime Requests from Heroku Log Drains via WebSockets**](http://cartologger.tonyta.com)

![Cartologger Map](https://github.com/tonyta/cartologger/blob/master/cartologger-map.jpg)

## How It Works
Cartologger receives [Heroku HTTPS log drains](https://devcenter.heroku.com/articles/log-drains)
via `POST /logplex` and, from the router logs, parse the original client
IP address of each successful request to the target Heroku app.

Each IP is geolocated via [Freegeoip.net](https://freegeoip.net)
(the result of which is cached into [Redis](http://redis.io)).
The lat/long coordinates are pushed to the web-client using
[Rails 5's ActionCable](https://github.com/rails/rails/tree/master/actioncable).

The web-client uses [Mapbox.js](https://www.mapbox.com/mapbox.js) and
[Leaflet.markercluster](https://github.com/Leaflet/Leaflet.markercluster)
to display live realtime Heroku app requests on a map.

## How To Use It

### Dependencies

The only real dependency is [Redis](http://redis.io). Make sure you have
is installed and that the `redis-server` is running.

### Running Development Servers

You'll need to make sure you have Redis running before starting...

Clone the repo:
``` bash
git clone https://github.com/tonyta/cartologger.git
cd cartologger/
```

Install gem dependencies and run tests:
``` bash
bundle install
bin/rspec
```

Echo your [Mapbox Public Key](https://www.mapbox.com/studio/account/tokens/)
into your `.env` file:
``` bash
# The public key below is just an example. You'll need to get your own.
echo "MAPBOX_PUBLIC_KEY: pk.eyJ1IjoiZm9vIiwiYSI6ImJhciIsImFsZyI6Ik.AkX0xyUS0coZ3t7EZUKW33" >> .env
```

Run the Rails server in a separate tab, or daemonize with the `--daemon` option:
``` bash
bin/rails s
```

Run Sidekiq process in a separate tab, or daemonize with the
`--daemon --logfile path/to/log` options:
``` bash
bundle exec sidekiq
```

Navigate your browser to `http://localhost:3000` and you should see a blank map.

Run the following rake task:
``` bash
bin/rake mock_log_drain
```

This task will post into your server at `/logplex` with a fake log drain.
You should see markers populating the map in your browser.

### Populating Live Heroku Log Events

Make sure the app can accept external requests and add it to your Heroku
log drains:
``` bash
heroku drains:add https://where-you-deployed-cartologger.com/logplex --app your-heroku-app
```

## Feature Requests
- Tooltip on each marker displaying the city and country of the request.
- Statistics and history per visitor (IP address).
- Sorting and selection based on host, path, and method.
- Only display most recent 50,000 (or so).
- Reset button to clear map.
- Automatically scroll map to latest activity.
- Color and size tweaks for clusters.
- Presentation mode.

