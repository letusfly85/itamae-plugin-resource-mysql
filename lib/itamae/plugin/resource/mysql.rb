#require "itamae/plugin/resource/mysql/version"
require "itamae/resource/base"
require "mysql2"

module Itamae
  module Plugin
    module Resource
      class Mysql < Itamae::Resource::Base
        COMMAND = 'mysql'
        define_attribute :action, default: :start #, :stop, :restart, :create_user, :drop_user

        define_attribute :loginuser, type: String, default_name: false
        define_attribute :loginpass, type: String, default_name: false

        define_attribute :username, type: String, default_name: false
        define_attribute :password, type: String, default_name: false
        define_attribute :database, type: String, default_name: false
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
            Itamae::Logger.info "create database..."
            query = "create database #{attributes.database}"
            Itamae::Logger.info query
            results = @client.query(query)
        end

        def action_create_user
            query = %q{create user #{attributes.username} identified by '#{attributes.password}'}
            results = @client.query(query)
        end

        def action_drop_user
            #TODO
        end
        
      end
    end
  end
end
