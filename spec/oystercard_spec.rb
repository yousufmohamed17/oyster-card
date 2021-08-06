require "oystercard"

describe Oystercard do
  before { subject.top_up(20) }
  let(:station) { double("station") }

  it "new cards should have a default balance" do
    expect(Oystercard.new.balance).to eq(Oystercard::DEFAULT_BALANCE)
  end

  describe "#top_up method" do
    it "should top up by given amount" do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'should raise error when balance limit is going to be passed' do 
      msg = "The top up limit is #{Oystercard::TOP_UP_LIMIT}"
      expect { subject.top_up(Oystercard::TOP_UP_LIMIT) }.to raise_error msg
    end
  end

  describe "#deduct" do
    it "should deduct by fare" do
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
  end

  describe "#in_journey?" do
    it "should return true after touch in" do
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it "should return false after touch out" do
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe "#touch_in" do
    it "should raise error if balance < #{Oystercard::MINIMUM_BALANCE}" do
      message = "You must top up"
      expect { Oystercard.new.touch_in(station) }.to raise_error message
    end

    it "should record entry station" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it "should set exit_station to nil" do
      subject.touch_in(station)
      expect(subject.exit_station).to eq(nil)
    end
  end

  describe "#touch_out" do
    it "should record exit station" do
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end

    it "should set entry_station to nil" do
      subject.touch_out(station)
      expect(subject.entry_station).to eq(nil)
    end
  end
end
