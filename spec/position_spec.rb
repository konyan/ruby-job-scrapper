# frozen_string_literal: true

require "position"

RSpec.describe Position do
  let(:position) { Position.new("Account", 1) }

  it "has a name" do
    expect(position.name).to eq("Account")
  end

  it "has a position" do
    expect(position.position).to eq(1)
  end
end
