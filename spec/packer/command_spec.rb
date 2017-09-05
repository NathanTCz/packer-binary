module Packer
  module Binary
    describe Command do
      context 'Packer v1.0.4' do
        before do
          Packer::Binary.configure do |config|
            config.version = '1.0.4'
          end
        end

        it 'runs command with binary' do
          expect(Packer::Binary::Command.run('--help > /dev/null')).to eq true
        end
      end
    end
  end
end
