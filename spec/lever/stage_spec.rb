RSpec.describe Lever::Stage do
  describe '#initialize' do
    it "works" do
      stage = Lever::Stage.new(Payloads::STAGE)
      expect(stage.text).to eql("New lead")
      expect(stage.id).to eql("lead-new")
    end
  end
end
