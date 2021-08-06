require "journey"

describe Journey do
  let(:subject) { described_class.new("King's Cross") }

  describe '#initialize method' do
    it "should have entry_station attribute" do
      expect(subject).to have_attributes(:entry_station => "King's Cross")
    end
  end

  describe '#end_journey method' do
    it "should have record exit station" do
      subject.end_journey("Oval")
      expect(subject.exit_station).to eq("Oval")
    end

    it "should log journey" do
      log = { :entry_station => "King's Cross", :exit_station => "Oval" }
      expect(subject.end_journey("Oval")).to eq(log)
    end
  end

  describe '#fare method' do
    it "should return #{Journey::MINIMUM_FARE} if journey is complete" do
      subject.end_journey("Oval")
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end

    it "should return #{Journey::PENALTY_FARE} if journey is incomplete" do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
  end

  describe '#complete? method' do
    it "should return true if journey is complete" do
      subject.end_journey("Oval")
      expect(subject.complete?).to eq(true)
    end

    it "should return false if journey is incomplete" do
      expect(subject.complete?).to eq(false)
    end
  end
end
