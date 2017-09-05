require 'zip'

module Packer
  module Binary
    # This class is used to zip and unzip files and directories
    class Compressor
      class << self
        include Packer::Binary::Helpers

        # Zip the input directory.
        def write(input_dir, output_file)
          entries = Dir.entries(input_dir)
          entries.delete('.')
          entries.delete('..')
          io = Zip::File.open(output_file, Zip::File::CREATE)

          write_entries(entries, '', io, input_dir, output_file)
          io.close
        end

        # Unzip the input zipfile
        def extract(input_file, output_dir)
          Zip::File.open(input_file) do |zip_file|
            # Handle entries one by one
            zip_file.each do |entry|
              # Extract to file/directory/symlink
              dest_file = "#{output_dir}/#{entry.name}"
              debug("Extracting to #{dest_file}")
              entry.extract(dest_file)
            end
          end
        end

        private

        # A helper method to make the recursion work.
        def write_entries(entries, path, io, input_dir, output_file)
          entries.each do |e|
            zip_file_path = path == '' ? e : File.join(path, e)
            disk_file_path = File.join(input_dir, zip_file_path)

            if File.directory?(disk_file_path)
              io.mkdir(zip_file_path)
              subdir = Dir.entries(disk_file_path)
              subdir.delete('.')
              subdir.delete('..')
              write_entries(subdir, zip_file_path, io, input_dir, output_file)
            else
              io.get_output_stream(zip_file_path) { |f| f.puts(File.open(disk_file_path, 'rb').read) }
            end
          end
        end
      end
    end
  end
end
