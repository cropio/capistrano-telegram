require_relative 'helpers'

module Capistrano
  module Messaging
    class Telegram
      include Helpers

      extend Forwardable
      def_delegators :env, :fetch


      DEFAULT_MESSAGES = {
          updating: "#{deployer} has started deploying branch #{branch} of #{application} to #{stage}",
          reverting: "#{deployer} has started rolling back branch #{branch} of #{application} to #{stage}",
          updated: "#{deployer} has finished deploying branch #{branch} of #{application} to #{stage}",
          reverted: "#{deployer} has finished rolling back branch of #{application} to #{stage}",
          failed: "#{deployer} has failed to #{deploying? ? 'deploy' : 'rollback'} branch #{branch} of #{application} to #{stage}"
      }

      def payload_for(action)
        text = fetch("message_for_#{action}".to_sym) || DEFAULT_MESSAGES[action]
        { text: text, parse_mode: 'markdown' }
      end

    end
  end
end