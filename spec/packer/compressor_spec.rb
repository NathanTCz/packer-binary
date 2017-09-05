module Packer
  module Binary
    describe Compressor do
      it 'deflates a directory' do
        Compressor.write('spec', '/tmp/spec.zip')
        expect(File.exist?('/tmp/spec.zip')).to be true
      end

      it 'inflates a zip' do
        Compressor.extract('/tmp/spec.zip', '/tmp/spec')
        expect(Dir.exist?('/tmp/spec')).to be true
        FileUtils.rm_rf('/tmp/spec')
        FileUtils.rm_rf('/tmp/spec.zip')
      end
    end
  end
end
