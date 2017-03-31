require 'json'

env ||= ENV['APP_ENV'] || 'development'

config_file = "#{env}.json"

config_full_path = File.join __dir__, config_file

Config = JSON.load File.new(config_full_path), nil, symbolize_names: true, create_additions: false
