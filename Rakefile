require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yaml'


task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress"]
end

desc "Migrate the database through scripts in db/migrate."
task :migrate do
  require 'percival'
  ActiveRecord::Base.establish_connection(YAML.load(File.read(File.join('config','database.yml')))[ENV['ENV'] ? ENV['ENV'] : 'development'])
  ActiveRecord::Migrator.migrate("/home/martin/percival/db/migrate/")
end

desc "Create migration file."
task :create_migration do
  
end


task :c => :console
desc "start up a irb console"
task :console do
  require 'percival'
  system 'bundle exec pry'
end


desc "start percival, connect to all channels in the CHANNELS env var" 
task :start do
  system 'mkdir -p data/timesheets/'
  channels = ENV["CHANNELS"] && ENV["CHANNELS"].split(/,\s*/) || ["#lpmc-bot"]
  nick = ENV["NICK"] || "percival"
  server = 'irc.freenode.com'

  require 'percival'

  db_config = YAML::load(File.open(File.join(File.dirname(__FILE__),'config','database.yml')))['development']
  ActiveRecord::Base.establish_connection(db_config)
  
  bot = Cinch::Bot.new do
    configure do |c|
      c.server = server
      c.channels = channels
      c.nick = nick
      c.plugins.plugins = [ClockPlugin,
                           LoggerPlugin,
                           ChannelChangerPlugin,
                           NameChangerPlugin]
    end
    
    #just to check if he's responding
    on :message, "hello" do |m|
      m.reply "Hello, #{m.user.nick}"
    end
  end

  bot.start
end
