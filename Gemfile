source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.6"
gem "sprockets-rails"

gem "bootsnap", require: false
gem "importmap-rails"
gem "pg", "~> 1.5"
gem "puma", "~> 6.3"
gem "slim-rails", "~> 3.6.1"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.0"
gem "turbo-rails"
gem "view_component"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "guard-rspec", require: false
  gem "pry"
  gem "rspec-rails", "~> 6.0.3"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "simplecov"
  gem "selenium-webdriver", "~> 4.14"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "dockerfile-rails", ">= 1.5", :group => :development
