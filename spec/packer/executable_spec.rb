module Packer
  module Binary
    describe Executable do
      context 'Packer v1.0.4' do
        before do
          Packer::Binary.configure do |config|
            config.version = '1.0.4'
            config.download_path = '/tmp'
          end
        end

        it 'downloads & extracts binary' do
          b = Executable.new
          b.download
          b.extract
          expect(b.binary.nil?).to be false
        end
      end
    end
  end
end
