require 'log4r'
include Log4r

module Unfuddle
  module Resources
    class Base < ActiveResource::Base
      self.format = :json
      
      log = Logger.new 'unfuddle'
      log.outputters = Outputter.stdout
      self.logger = log
      
      def self.set_account(acc)
        self.site = acc.url + "/api/v1"
        self.user = acc.user
        self.password = acc.password
      end
    end
  
    class Repository < Base
      # Get repository changesets
      def changesets
        Changeset.find(:all, :from => "/repositories/#{self.id}/changesets")
      end
      
      # Find repository by abbreviation
      def self.find_by_abbr(value)
        r = Repository.all.select { |r| r.abbreviation == value }
        r.empty? ? nil : r.first
      end
    end
    
    class Changeset < Base ; end
    
    class Project < Base
    end

    class Ticket < Base
      def self.site
        Base.site + "/api/v1/projects/1"
      end
    end
    
    class Account < Base
      # Get primary account
      def self.primary
        find(:one, :from => '/account')
      end
    end
    
    class Person < Base
      def name
        "#{self.first_name} #{self.last_name}".strip
      end
    end
    
    class Component < Base
      def self.site
        Base.site + "/api/v1/projects/1"
      end
    end
    
    class Milestone < Base
      def self.site
        Base.site + "/api/v1/projects/1"
      end
    end

    class Version < Base
      def self.site
        Base.site + "/api/v1/projects/1"
      end
    end
  end
end