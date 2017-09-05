module Packer
  module Binary
    # This module handles running the actual CLI commands
    module Command
      module_function

      # Raised when a command either fails or is invalid
      class CommandFailure < StandardError; end

      # Runs the given command with `Core::Kernel.system`
      # Example `run('sub-command -var "key=value" -machine-readable')`
      # @param [String] command the full sub-command to run (including cli arguments)
      # @return [String] true or {CommandFailure}
      def run(command)
        system("#{binary} #{command}") || (raise CommandFailure)
      end

      # Downloads, extracts and returns the path to the binary
      # @return [String] absolute path of the binary
      def binary
        e = Executable.new
        e.download
        e.extract
        e.binary
      end
    end
  end
end
