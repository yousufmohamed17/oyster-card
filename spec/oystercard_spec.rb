require "oystercard"

describe Oystercard do
  it "should have a balance" do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end
end
