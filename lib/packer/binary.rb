require 'os'

require "packer/binary/version"
require 'packer/binary/helpers'
require 'packer/binary/compressor'
require 'packer/binary/executable'
require 'packer/binary/command'

module Packer
  module Binary
    module_function

    attr_writer :config

    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end

    def Build(opts = '')
      Command.run("build #{opts}")
    end

    def Fix(opts = '')
      Command.run("fix #{opts}")
    end

    def Inspect(opts = '')
      Command.run("inspect #{opts}")
    end

    def Push(opts = '')
      Command.run("push #{opts}")
    end

    def Validate(opts = '')
      Command.run("validate #{opts}")
    end

    def Version(opts = '')
      Command.run("version #{opts}")
    end

    class Configuration
      attr_accessor :version
      attr_accessor :download_path

      def initialize
        @version = '1.0.4'
        @download_path = '/tmp'
      end
    end
  end
end
