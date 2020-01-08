RSpec.describe Lever::Opportunity do
  describe '#initialize' do
    it "works" do
      opportunity = Lever::Opportunity.new(Payloads::OPPORTUNITY)
      expect(opportunity.name).to eql("Tony Stark")
      expect(opportunity.applications.first).to be_a(Lever::Application)
    end
  end
end
