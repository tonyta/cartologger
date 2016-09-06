require "redis"
require "http"

class IPLocator
  RedisClient = Redis.new(db: 2)

  ResponseAttrs = %i{
    ip time_zone latitude longitude city metro_code zip_code
    country_code country_name region_code region_name
  }

  attr_reader :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  ResponseAttrs.each do |attr|
    define_method(attr) { geo_hash[attr] }
  end

  def names
    geo_hash.values_at(:city, :region_name, :country_name).select(&:present?)
  end

  def geo_hash
    @geo_hash ||= JSON.parse(geo_json, symbolize_names: true)
  end

  def geo_json
    @geo_json ||= RedisClient[ip_address] ||= fetch_geo_json
  end

  def fetch_geo_json
    res = HTTP.get("https://freegeoip.net/json/#{ip_address}")
    if res.status.ok?
      res.to_s.chomp
    else
      fail "Response from GeoIP service not 200 OK: #{res.to_a}"
    end
  end
end
