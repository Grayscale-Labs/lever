RSpec.describe Lever::Stage do
  describe '#initialize' do
    let(:stage) { Lever::Stage.new(build(:lever_stage_response)) }
    it "works" do
      expect(stage.text).to eql("New lead")
      expect(stage.id).to eql("lead-new")
    end
  end
end
