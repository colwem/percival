require 'cinch'

require 'percival/version'
require 'percival/clock'
require 'percival/logger'
require 'percival/channel_changer'
require 'percival/name_changer'
require 'percival/router'

Bundler.require

PERCIVAL_ROOT = File.dirname(File.dirname(__FILE__))
PR = File.dirname(__FILE__)
Dir.glob(File.join(PR, 'percival', 'models', '*.rb')).each do |r|
  require r
end

Dir.glob(File.join(PR, 'percival', 'routes', '*.rb')).each do |r|
  require r
end
Dir.glob(File.join(PR, 'percival', 'controllers', '*.rb')).each do |r|
  require r
end
