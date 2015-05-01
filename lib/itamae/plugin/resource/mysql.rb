require "itamae/resource/base"
require "mysql2"

module Itamae
  module Plugin
    module Resource
      class Mysql < Itamae::Resource::Base
        COMMAND = 'mysql'
        define_attribute :action

        define_attribute :loginuser, type: String, default_name: false
        define_attribute :loginpass, type: String, default_name: false

        define_attribute :username, type: String, default_name: false
        define_attribute :password, type: String, default_name: false

        define_attribute :database, type: String, default_name: false
        define_attribute :if_not_exists, type: String, default_name: false

        define_attribute :host, type: String, default_name: false
        define_attribute :port, type: String, default_name: false

        def set_current_attributes
            begin
            @client = 
                Mysql2::Client.new(:host => attributes.host,
                                   :user => attributes.loginuser,
                                   :password => attributes.loginpass,
                                   :port => attributes.port)
            rescue => e
                Itamae::Logger::info e
                raise e
            end
        end

        def action_create_database(options)
            if attributes.if_not_exists
                @query = "create database if not exists #{attributes.database}"
            else
                @query = "create database if not exists #{attributes.database}"
            end

            Itamae::Logger.info @query
            results = @client.query(@query)
            Itamae::Logger.info "created #{attributes.database}."
        end

        def action_create_user
            query = %q{create user #{attributes.username} identified by '#{attributes.password}'}
            results = @client.query(query)
        end

        def action_drop_user
            query = "drop user #{attributes.username}"

            Itamae::Logger.info query
            results = @client.query(query)
            Itamae::Logger.info "dropped #{attributes.username}."
        end
        
      end
    end
  end
end
