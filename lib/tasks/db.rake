namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require_relative '../../db/db'
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DB, "db/migrations")
    end
  end
end
