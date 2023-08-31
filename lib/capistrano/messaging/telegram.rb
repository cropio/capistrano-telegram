require_relative 'helpers'

module Capistrano
  module Messaging
    class Telegram
      include Helpers

      extend Forwardable
      def_delegators :env, :fetch

      def payload_for(action)
        message_type = "message_for_#{action}"
        {
            text: fetch(message_type.to_sym) || send(message_type),
            parse_mode: 'markdown'
        }
      end

      private

      def message_for_updating
        "#{deployer} has started deploying branch #{branch} of #{application} to #{stage}"
      end

      def message_for_reverting
        "#{deployer} has started rolling back branch #{branch} of #{application} to #{stage}"
      end

      def message_for_updated
        "#{deployer} has finished deploying branch #{branch} of #{application} to #{stage}"
      end

      def message_for_reverted
        "#{deployer} has finished rolling back branch of #{application} to #{stage}"
      end

      def message_for_failed
        "#{deployer} has failed to #{deploying? ? 'deploy' : 'rollback'} branch #{branch} of #{application} to #{stage}"
      end
    end
  end
end