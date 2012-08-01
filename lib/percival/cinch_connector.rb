class CinchConnector
  include Cinch::Plugin

  match /(.*)/

  def execute m, all
    Percival::Router.dispatch m, all
  end
end

  
