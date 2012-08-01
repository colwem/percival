module Percival
  class Controller

    attr_reader :bot
    
    def initialize 
    end

    def set_env msg
      @bot = msg.bot
      @m = msg
    end
    
    def reply str
      m.reply str
    end
    
  end
end
