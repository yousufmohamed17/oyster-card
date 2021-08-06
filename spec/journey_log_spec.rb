require "journey_log"

describe JourneyLog do
  let(:subject) { described_class.new("Journey") }

  describe '#initialize method' do
    it "should have journey and journeys attribute" do
      expect(subject).to have_attributes(:journey_class => "Journey", :journey_log => [])
    end
  end
end
