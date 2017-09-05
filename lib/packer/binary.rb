require 'os'

require 'packer/binary/version'
require 'packer/binary/helpers'
require 'packer/binary/compressor'
require 'packer/binary/executable'
require 'packer/binary/command'

# This module handles downloading and extracting of the associated binary as well
# as providing a dynamic namespace and ruby client for sub-commands of said binary
module Packer
  # The Binary namespace handles sub-commands using {#method_missing} metaprogramming
  # as well as the global configuration object
  module Binary
    # @!attribute config
    #   @return [Configuration] the global configuration object
    attr_writer :config

    module_function

    # defines the @config class variable
    def config
      @config ||= Configuration.new
    end

    # Set the global settings. See the {file:README.md README} for more information
    def configure
      yield(config)
    end

    # This method maps Packer::Binary method calls to Packer sub-commands
    # Ex. to run `packer build test.json -machine-readable`:
    #
    # ```ruby
    # Packer::Binary.build('test.json -machine-readable')
    # ```
    #
    # @note if the method is an invalid sub-command or if the command fails
    #   you will get a {Command::CommandFailure} exception
    # @since 0.2.0
    def method_missing(method, *args, &block)
      if method.to_s =~ /(\w+)/
        Command.run("#{method.to_s.downcase} #{args}")
      else
        super
      end
    end

    def respond_to_missing?(method, *)
      method =~ /(\w+)/ || super
    end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Build; end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Fix; end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Inspect; end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Push; end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Validate; end

    # @deprecated Use {#method_missing} dynamic method handling for
    #   binary sub-commands
    def Version; end

    # This class holds the global configuration items
    class Configuration
      attr_accessor :version
      attr_accessor :download_path

      def initialize
        @version = PACKER_VERSION
        @download_path = '/tmp'
      end
    end
  end
end
