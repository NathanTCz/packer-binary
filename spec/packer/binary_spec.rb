require "spec_helper"

module Packer
  describe Binary do

    it 'has a version number' do
      expect(Packer::Binary::VERSION).not_to be nil
    end

    # Define Public interface
    it { should respond_to(:Build) }
    it { should respond_to(:Fix) }
    it { should respond_to(:Inspect) }
    it { should respond_to(:Push) }
    it { should respond_to(:Validate) }
    it { should respond_to(:Version) }

  end
end
