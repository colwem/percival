module Percival
  class Router

    def self.draw
      @@routeset = Route.new
      yield @@routeset
      @@routeset.route '.*', controller: :default, action: :command_not_found
    end

    def self.dispatch msg, command
      #      Percival::Environment.msg = msg
      load_routes!
      route = @@routeset.match command 
      controller = find_controller route.controller
      controller.set_env msg
      controller.send(route.action, route.remainder)
    end

    def self.find_controller controller 
      if controller.is_a? Percival::Controller
        return controller.new
      elsif controller.is_a? String or controller.is_a? Symbol
        controller_s = camelize controller
        eval "controller = ::#{controller_s}.new"
        return controller
      end
      throw Exception "controller not found"
    end

    def self.load_routes!
      Dir.glob(File.join(route_files_dir, '*.rb')).each do |f|
        load f
      end
    end

    def self.route_files_dir
      File.join( PERCIVAL_ROOT, 'percival', 'routes')
    end
    
    def self.camelize str
      str = str.to_s
      str.gsub(/([A-Za-z]*)_?/) {$1.capitalize}
    end

  end

  class Route
    def initialize pattern='^', options={}
      @pattern, @options  = pattern, options
      convert_pattern!
      @routes = []
    end
    
    def route pattern, options={}
      route =  Route.new pattern, options
      @routes.push route      
      if block_given?
        yield route
      end
    end
    
    def match str
      m = @pattern.match str
      if m
        self.remainder = str.sub(@pattern, '')
        unless @routes.empty?
          sub_route = nil
          @routes.each do |r|
            if sub_route = r.match(self.remainder)
              break
            end
          end
          if sub_route
            self.controller = sub_route.controller if sub_route.controller
            self.action = sub_route.action if sub_route.action
            self.remainder = sub_route.remainder
          end
        end
        return self
      end
      false
    end
    
    def convert_pattern!
      return if @pattern.is_a? Regexp
      @pattern = Regexp.new( @pattern) and return if @pattern.is_a? String
      throw Exception "pattern is not a string or Regexp"
    end
    def controller= controller
      @options[:controller] = controller
    end

    def action= action
      @options[:action] = action
    end
    
    def controller
      @options[:controller]
    end

    def action
      @options[:action]
    end

    def remainder= str
      @remainder = str
    end

    def remainder
      @remainder
    end
        
    alias prefix route
  end

  class Controller
  end
  
end


