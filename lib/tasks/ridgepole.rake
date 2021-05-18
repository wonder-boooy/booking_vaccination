namespace :ridgepole do
  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply', '-f')
  end

  desc 'Export database schema'
  task export: :environment do
    ridgepole('--export', '--split', '-o')
  end

  private

    def config_file
      raise 'no configuration specified' unless Rails.env.development? || Rails.env.production?

      'config/database.yml'
    end

    def ridgepole(*options)
      command = ['bundle exec ridgepole', "-c #{config_file}", "-E #{Rails.env}"]
      schemafile = ['db/schemas/Schemafile']
      puts '=== run ridgepole ==='
      puts "runnning '#{(command + options + schemafile).join(' ')}'"
      system (command + options + schemafile).join(' ')
    end
end
