require "oystercard"

describe Oystercard do
  it "should have a balance" do
    expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  describe "#top_up method" do
    it "should top up by given amount" do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'should raise error when balance limit is going to be passed' do 
      message = "The top up limit is #{Oystercard::TOP_UP_LIMIT}"
      subject.top_up(Oystercard::TOP_UP_LIMIT)
      expect { subject.top_up(1) }.to raise_error message
    end
  end

  describe "#deduct" do
    it "should deduct by fare" do
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end
end
