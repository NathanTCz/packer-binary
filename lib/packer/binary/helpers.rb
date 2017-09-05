module Packer
  module Binary
    # Generic helper methods
    module Helpers
      module_function

      # Runs given commands using mixlib-shellout
      def system_command(*command_args)
        cmd = Mixlib::ShellOut.new(*command_args)
        cmd.run_command
        cmd
      end

      # prints to `stderr`
      def err(message)
        stderr.print("#{message}\n")
      end

      # prints to `stdout`
      def msg(message)
        stdout.print("#{message}\n")
      end

      # prints to `stfout` if `ENV['DEBUG']` is set
      def debug(message)
        stdout.print("#{message}\n") if ENV['DEBUG']
      end

      def stdout
        $stdout
      end

      def stderr
        $stderr
      end
    end
  end
end
