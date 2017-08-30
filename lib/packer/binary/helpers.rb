module Packer
  module Binary
    module Helpers
      module_function

      #
      # Runs given commands using mixlib-shellout
      #
      def system_command(*command_args)
        cmd = Mixlib::ShellOut.new(*command_args)
        cmd.run_command
        cmd
      end

      def err(message)
        stderr.print("#{message}\n")
      end

      def msg(message)
        stdout.print("#{message}\n")
      end

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
