RSpec.describe Lever::Opportunity do
  describe '#initialize' do
    it "works" do
      opportunity = Lever::Opportunity.new(Payloads::OPPORTUNITY)
      expect(opportunity.name).to eql("Tony Stark")
      expect(opportunity.applications.first).to be_a(Lever::Application)
      expect(opportunity.stage_id).to eql("lead-new")
      expect(opportunity.stage_name).to eql("New lead")
    end
  end
end
