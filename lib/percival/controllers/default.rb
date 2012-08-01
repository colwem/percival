class Default < Percival::Controller

  def command_not_found command
    reply "#{command} is not a valid command"
  end
end
