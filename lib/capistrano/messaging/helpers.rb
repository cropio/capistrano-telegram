module Capistrano
  module Messaging
    module Helpers

      def icon_emoji
        options.fetch(:icon_emoji, nil)
      end

      def deployer
        git_name = `git config --global --get user.name`.chomp

        default = ENV['USER'] || ENV['USERNAME'] || git_name
        fetch(:local_user, default)
      end

      def branch
        "*#{fetch(:branch, "unknown branch")}*"
      end

      def application
        fetch(:application)
      end

      def stage(default = "an unknown stage")
        "*#{fetch(:stage, default)}*"
      end

      #
      # Return the elapsed running time as a string.
      #
      # Examples: 21-18:26:30, 15:28:37, 01:14
      #
      def elapsed_time
        `ps -p #{$$} -o etime=`.strip
      end

    end
  end
end
