Percival::Router.draw do |r|

  r.prefix 'cf', controller: :connect_four do |r|
    r.route 'new', action: :new
    r.route '[1-7]', action: :dont_know
  end

  r.route 'change-name', controller: :name_changer, action: :change_name
  r.route 'leave-channel', controller: :channel_changer, action: :part
  r.route 'join-channel', controller: :channel_changer, action: :part
end
