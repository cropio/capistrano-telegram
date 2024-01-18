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

      def start_ico
        "\u{1F6A2} \u{1F6A2} \u{1F6A2}"
      end

      def finish_ico
        "\u{2705} \u{2705} \u{2705}"
      end

      def fail_ico
        "\u{1F631} \u{1F631} \u{1F631}"
      end

      def revert_ico
        "\u{27B0} \u{27B0} \u{27B0}"
      end

      # TODO: fix branch_with_rev
      # now text wrong see below
      # vadym has started deploying branch master rev. <https://github.com/syngenta-digital/fullstack-rails-cwo/commit/origin/master|origin/> of cropio to production

      def message_for_updating
        "#{start_ico} #{deployer} has started deploying branch #{branch_with_rev} of #{application} to #{stage}"
      end

      def message_for_reverting
        "#{revert_ico} #{deployer} has started rolling back branch #{branch} of #{application} to #{stage}"
      end

      def message_for_updated
        "#{finish_ico} #{deployer} has finished deploying branch #{branch} of #{application} to #{stage}"
      end

      def message_for_reverted
        "#{finish_ico} #{deployer} has finished rolling back branch of #{application} to #{stage}"
      end

      def message_for_failed
        "#{fail_ico} #{deployer} has failed to #{deploying? ? 'deploy' : 'rollback'} branch #{branch} of #{application} to #{stage}"
      end
    end
  end
end
