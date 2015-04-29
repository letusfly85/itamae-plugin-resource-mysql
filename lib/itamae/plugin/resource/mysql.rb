#require "itamae/plugin/resource/mysql/version"
require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Mysql < Itamae::Resource::Base
        COMMAND = 'mysql'
        define_attribute :action, :default, :start, :stop, :restart, :create_user, :drop_user

        def set_current_attributes
            #TODO
        end


        def action_start
            #TODO
        end

        def action_stop
            #TODO
        end

        def action_restart
            #TODO
        end

        def action_create_user
            #TODO
        end

        def action_drop_user
            #TODO
        end
        
      end
    end
  end
end
