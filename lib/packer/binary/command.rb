module Packer
  module Binary
    module Command
      module_function

      def run(command)
        system("#{binary} #{command}")
      end

      def binary
        e = Executable.new
        e.download
        e.binary
      end
    end
  end
end
