require "oystercard"
require "station"
require "journey"

describe Oystercard do
  before { subject.top_up(20) }
  let(:station) { double(Station.new("King's Cross", 1)) }
  
  describe "#initialize method" do
    it "new cards should have a default balance" do
      expect(Oystercard.new.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end

    it "should have an empty journey log array" do
      expect(subject.journey_log).to eq([])
    end

    it "should record the current journey as nil" do
      expect(subject.journey).to eq(nil)
    end
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

  describe "#touch_in" do
    it "should charge a penalty fare if previous journey is incomplete" do
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(-Journey::PENALTY_FARE)
    end

    it "should raise error if balance < #{Oystercard::MINIMUM_BALANCE}" do
      message = "You must top up"
      expect { Oystercard.new.touch_in(station) }.to raise_error message
    end

    it "should start a new journey" do
      subject.touch_in(station)
      expect(subject.journey).not_to eq(nil)
    end
  end

  describe "#touch_out" do
    it "should record journey history" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_log.last).to eq({ :entry_station => station, :exit_station => station })
    end

    it "should charge a penalty fare if there wasn't a touch in" do
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Journey::PENALTY_FARE)
    end

    it "should charge a minimum fare if there was a touch in" do
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
    end

    it "should set the journey to nil" do
      subject.touch_out(station)
      expect(subject.journey).to eq(nil)
    end
  end
end
