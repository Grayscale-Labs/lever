RSpec.describe Lever::Opportunity do
  describe '#initialize' do
    it "works" do
      posting = Lever::Posting.new(Payloads::POSTING)
      expect(posting.text).to eql("Super Hero")
      expect(posting.req_code).to be_nil
    end
  end
end
