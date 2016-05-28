require "spec_helper"

require_relative APP_ROOT/"services/ip_locator.rb"

describe IPLocator do
  subject { described_class.new("8.8.8.8") }

  before do
    stub_request(:get, "https://freegeoip.net/json/8.8.8.8").
      to_return(
        status: 200,
        headers: { "Content-Type" => "application/json", "Content-Length" => "247" },
        body: "{\"ip\":\"8.8.8.8\",\"country_code\":\"US\",\"country_name\":\"United States\",\"region_code\":\"CA\",\"region_name\":\"California\",\"city\":\"Mountain View\",\"zip_code\":\"94035\",\"time_zone\":\"America/Los_Angeles\",\"latitude\":37.386,\"longitude\":-122.0838,\"metro_code\":807}\n"
      )
  end

  its(:ip_address) { should eq "8.8.8.8" }

  describe "fetching and caching" do
    it "fetches only once and caches for every other request" do
      Redis.new(db: 0).del("8.8.8.8")

      instance = described_class.new("8.8.8.8")
      expect(instance.geo_json).to include '"ip":"8.8.8.8"'
      expect(instance.geo_json).to include '"ip":"8.8.8.8"'

      new_instance = described_class.new("8.8.8.8")
      expect(new_instance.geo_json).to include '"ip":"8.8.8.8"'
      expect(new_instance.geo_json).to include '"ip":"8.8.8.8"'

      expect(WebMock).to have_requested(:get, "https://freegeoip.net/json/8.8.8.8").once
    end
  end

  describe "raw attributes" do
    its(:ip)           { should eq "8.8.8.8" }
    its(:country_code) { should eq "US" }
    its(:country_name) { should eq "United States" }
    its(:region_code)  { should eq "CA" }
    its(:region_name)  { should eq "California" }
    its(:city)         { should eq "Mountain View" }
    its(:zip_code)     { should eq "94035" }
    its(:time_zone)    { should eq "America/Los_Angeles" }
    its(:latitude)     { should eq 37.386 }
    its(:longitude)    { should eq -122.0838 }
    its(:metro_code)   { should eq 807 }
  end
end
