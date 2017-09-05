require 'spec_helper'

module Packer
  describe Binary do
    it 'has a version number' do
      expect(Packer::Binary::VERSION).not_to be nil
    end

    # Define Public interface
    it { should respond_to(:build) }
    it { should respond_to(:fix) }
    it { should respond_to(:inspect) }
    it { should respond_to(:push) }
    it { should respond_to(:validate) }
    it { should respond_to(:version) }

    before do
      Packer::Binary.configure do |config|
        config.version = '1.0.4'
        config.download_path = '/tmp/tests'
      end
    end

    it 'configures options' do
      expect(Packer::Binary.config.download_path).equal? '/tmp/tests'
    end
  end
end
