ENV['APP_ENV'] = 'test'

require 'rake'
load File.expand_path('../../Rakefile', __FILE__)
Rake::Task['db:migrate'].invoke

require_relative '../app/boot'
