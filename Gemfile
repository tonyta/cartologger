source "https://rubygems.org"

ruby "2.3.0"
gem 'rails_12factor', group: :production

# gem "rails", "~> 5.0.0"
# Pick and choose Rails dependencies
gem "actioncable", "~> 5.0.0"
gem "actionpack", "~> 5.0.0"
gem "actionview", "~> 5.0.0"
gem "activejob", "~> 5.0.0"
gem "activemodel", "~> 5.0.0"
gem "activesupport", "~> 5.0.0"
gem "railties", "~> 5.0.0"
gem "sprockets-rails", ">= 3.2.0"

gem "redis", "~> 3.0"
gem "http"

gem "puma", "~> 3.0"
gem "sidekiq"

gem "uglifier", ">= 1.3.0"
gem "jquery-rails"

gem "pry-rails"

group :development, :test do
  gem "foreman"
  gem "dotenv-rails"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.5.0"
end

group :development do
  gem "web-console"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "rspec-its"
  gem "webmock"
end
