class NameChanger < Percival::Controller

  def change_name name
    unless user.roles.find(:name_changer)
      reply "you are not authorized to to change my name"
    else
      bot.nick = name
      reply "my name has been changed to #{name}"
    end
  end
end
