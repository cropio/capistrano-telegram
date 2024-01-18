module Capistrano
  module Messaging
    module Helpers

      def icon_emoji
        options.fetch(:icon_emoji, nil)
      end

      def deployer
        default = ENV["USER"] ||  ENV["USERNAME"]
        fetch(:local_user, default)
      end

      def branch
        "`#{fetch(:branch, "unknown")}`"
      end

      # vadym has started deploying branch master rev. <https://github.com/syngenta-digital/fullstack-rails-cwo/commit/origin/master|origin/> of cropio to production
      def branch_with_rev
        "`#{fetch(:branch, "unknown")}` rev. *<`#{link_rev}`|`#{short_rev}`>*"
      end

      def git_rev
        `git rev-parse origin/#{branch}`.strip!
      end

      def short_rev
        git_rev[0..6]
      end

      def link_rev
        "https://github.com/#{repo_path}/commit/#{git_rev}"
      end

      def repo_path
        repo_url.gsub(/(\Agit@github\.com:|\.git$)/, "")
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
