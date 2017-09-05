module Packer
  module Binary
    # This class handles downloading, extracting, and saving the associated
    # binary file
    class Executable
      include Packer::Binary::Helpers

      # Raised when the current platform is unsupported
      class PlatformUnsupported < StandardError; end

      # The download URI for the binary package
      PACKER_DOWNLOAD_URI = 'releases.hashicorp.com'.freeze

      # Loads global config values and creates the download directory if the
      # current platform is supported
      def initialize
        @packer_version = Packer::Binary.config.version
        @download_path = "#{Packer::Binary.config.download_path.chomp('/')}/packer-binary/#{@packer_version}/bin"
        @download_filename = "#{@packer_version}-packer.zip"

        FileUtils.mkdir_p @download_path

        raise PlatformUnsupported unless supported?
      end

      # Returns the path to the binary if it exists
      # @return [String] absolute path of the binary
      def binary
        Dir["#{@download_path}/packer*"][0]
      end

      # Downloads the zipfile from the origin
      def download
        return if binary_exist?

        msg("Downloading https://#{download_domain}/#{download_uri}")

        require 'open-uri'

        File.open("#{@download_path}/#{@download_filename}", 'wb') do |saved_file|
          # the following "open" is provided by open-uri
          open("https://#{download_domain}/#{download_uri}", 'rb') do |read_file|
            saved_file.write(read_file.read)
          end
        end
      end

      # Extracts the binary from the zipfile and makes it executable
      def extract
        return if binary_exist?

        Compressor.extract("#{@download_path}/#{@download_filename}", @download_path)
        make_exe
      end

      private

      def binary_exist?
        !binary.nil?
      end

      def supported?
        OS.freebsd? || OS.mac? || OS.windows? || OS.linux?
      end

      def make_exe
        FileUtils.chmod('a+x', binary) if binary_exist?
      end

      def download_uri
        "packer/#{@packer_version}/packer_#{@packer_version}_freebsd_amd64.zip" if OS.freebsd?
        "packer/#{@packer_version}/packer_#{@packer_version}_darwin_amd64.zip" if OS.mac?
        "packer/#{@packer_version}/packer_#{@packer_version}_windows_amd64.zip" if OS.windows?
        "packer/#{@packer_version}/packer_#{@packer_version}_linux_amd64.zip" if OS.linux?
      end

      def download_domain
        PACKER_DOWNLOAD_URI
      end
    end
  end
end
