module Unfuddle
  COMMANDS = {
    'setup'       => 'account:setup',
    'auth'        => 'account:auth',
    'account'     => 'account:info',
    'list'        => 'repository:index',
    'add'         => 'repository:create',
    'drop'        => 'repository:delete',
    'checkout'    => 'repository:checkout',
    'init'        => 'repository:init',
    'log'         => 'repository:log',
    'projects'    => 'project:index',
    'tickets'     => 'ticket:index',
    'ticket'      => 'ticket:create',
    'help'        => 'help:index',
    'people'      => 'people:index',
    'components'  => 'project:components',
    'milestones'  => 'project:milestones',
    'versions'    => 'project:versions'
  }

  class Command
    include Unfuddle::Terminal
    extend Unfuddle::Terminal
    
    # Current Homerun execution account
    attr_accessor :account
    
    def initialize(args)
      @args = args
    end
    
    # Execute command
    def self.run(command, args)
      begin
        run_internal(command, args.dup)
      rescue InvalidCommand => ex
        error "Unknown command '#{command}'. Run 'unfuddle help' for usage information."
        exit(1)
      rescue Interrupt
        error "\n[canceled]"
        exit(1)
      rescue Exception => ex
        error "Oooops... Error: #{ex.inspect}", ex
      end
    end
    
    # Create and execute command
    def self.run_internal(command, args)
      klass, method = parse(command)
      runner = klass.new(args)
      raise InvalidCommand unless runner.respond_to?(method)
      runner.send(method)
    end
    
    # Parse command
    def self.parse(command)    
      if Unfuddle::COMMANDS.key?(command)
        klass, method = Unfuddle::COMMANDS[command].split(':')
        begin
          return Unfuddle::Command.const_get("#{klass.capitalize}Command"), method
        rescue NameError
          raise InvalidCommand
        end
      else
        raise InvalidCommand
      end
    end
  end
  
  Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |c| require c }
end