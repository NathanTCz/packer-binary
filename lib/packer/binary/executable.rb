module Packer
  module Binary
    class Executable
      include Packer::Binary::Helpers

      def initialize
        @packer_version = Packer::Binary.config.version
        @download_path = "#{Packer::Binary.config.download_path.chomp('/')}/packer-binary/#{@packer_version}/bin"
        @download_filename = "#{@packer_version}-packer.zip"

        FileUtils.mkdir_p @download_path

        raise 'Your OS is not supported' unless supported?
      end

      def binary
        Dir["#{@download_path}/packer*"][0]
      end

      def download
        return "#{binary} already exists" if binary_exist?

        msg("Downloading https://#{download_domain}/#{download_uri}")

        require 'open-uri'

        File.open("#{@download_path}/#{@download_filename}", "wb") do |saved_file|
          # the following "open" is provided by open-uri
          open("https://#{download_domain}/#{download_uri}", "rb") do |read_file|
            saved_file.write(read_file.read)
          end
        end

        extract
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

      def extract
        Compressor::extract("#{@download_path}/#{@download_filename}", @download_path)
      end

      def download_uri
        "packer/#{@packer_version}/packer_#{@packer_version}_freebsd_amd64.zip" if OS.freebsd?
        "packer/#{@packer_version}/packer_#{@packer_version}_darwin_amd64.zip" if OS.mac?
        "packer/#{@packer_version}/packer_#{@packer_version}_windows_amd64.zip" if OS.windows?
        "packer/#{@packer_version}/packer_#{@packer_version}_linux_amd64.zip" if OS.linux?
      end

      def download_domain
        'releases.hashicorp.com'
      end

    end
  end
end
