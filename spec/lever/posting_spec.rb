RSpec.describe Lever::Opportunity do
  describe '#initialize' do
    let(:posting) { Lever::Posting.new(build(:lever_posting_response)) }
    it "works" do
      expect(posting.text).to eql("Super Hero")
      expect(posting.req_code).to be_nil
    end
  end
end
