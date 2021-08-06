require "station"

describe Station do
  let(:subject) { described_class.new("King's Cross", 1) }

  describe '#initialize method' do
    it "should have name and zone attribute" do
      expect(subject).to have_attributes(:name => "King's Cross", :zone => 1)
    end
  end
end
