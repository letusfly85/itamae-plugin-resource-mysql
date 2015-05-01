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
        define_attribute :user_hosts, type: Array , default: []
        define_attribute :user_priviliges, type: Array , default: []
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
            check_user_hosts

            attributes.user_hosts.each do |host|
                @query = "create user '#{attributes.username}'@'#{host}' identified by '#{attributes.password}'"

                Itamae::Logger.info @query
                results = @client.query(query)
                Itamae::Logger.info "created '#{attributes.username}'@'#{host}'."
            end
        end

        def action_grant_user
            check_user_hosts
            check_user_priviliges

            attributes.user_hosts.each do |host|
                attributes.user_priviliges.each do |privilige|
                    @query = "grant #{privilige} on #{attributes.database}.* to '#{attributes.username}'@'#{host}'"

                    Itamae::Logger.info @query
                    results = @client.query(query)
                    Itamae::Logger.info "granted #{privilige} to '#{attributes.username}'@'#{host}'."
                end
            end
        end

        def action_drop_user
            query = "drop user #{attributes.username}"

            Itamae::Logger.info query
            results = @client.query(query)
            Itamae::Logger.info "dropped #{attributes.username}."
        end

        private

        def check_user_hosts
            if attributes.user_hosts.length == 0
                raise "you should set host names in format ['host1', 'host2',...]"
            end
        end
        
        def check_user_priviliges
            if attributes.user_priviliges.length == 0
                raise "you should set grant options in format ['option1', 'option2',...]"
            end
        end
      end
    end
  end
end
