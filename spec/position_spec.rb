require "position"

RSpec.describe Position do
  let(:position) { Position.new("Account") }

  it "has a name" do
    expect(position.name).to eq("Account")
  end
end
