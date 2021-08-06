require "station"

describe Station do
  let(:subject) { described_class.new("Kings Cross", 1) }

  describe '#initialize method' do
    it "should have name and zone attribute" do
      expect(subject).to have_attributes(:name => "Kings Cross", :zone => 1)
    end
  end
end
