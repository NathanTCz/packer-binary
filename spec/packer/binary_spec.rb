require "spec_helper"

RSpec.describe Packer::Binary do
  it "has a version number" do
    expect(Packer::Binary::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
