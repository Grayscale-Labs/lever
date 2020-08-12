RSpec.describe Lever::Opportunity do
  let(:opportunity_response) { build(:lever_opportunity_response) }
  let(:opportunity) { Lever::Opportunity.new(opportunity_response) }

  describe '#initialize' do
    it "sets the name" do
      expect(opportunity.name).to eql("Tony Stark")
    end

    it 'sets the application' do
      expect(opportunity.applications.first).to be_a(Lever::Application)
    end

    it 'sets the stage_id' do
      expect(opportunity.stage_id).to eql("lead-new")
    end

    it 'sets the stage name' do
      expect(opportunity.stage_name).to eql("New lead")
    end
  end

  describe '#hired?' do
    context 'when archived exists' do
      let(:opportunity_response) { build(:lever_opportunity_response, :archived) }
      subject { opportunity.hired? }

      context 'when not a hired reason' do
        before { expect(opportunity).to receive(:hired_archive_reason?).and_return((false))}
        it { is_expected.to eql(false) }
      end

      context 'when a hired reason' do
        before { expect(opportunity).to receive(:hired_archive_reason?).and_return((true))}
        it { is_expected.to eql(true) }
      end
    end

    context 'when archived is empty' do
      subject { opportunity.hired? }
      it { is_expected.to eql(false) }
    end
  end
  
  describe '#rejected?' do
    context 'when archived exists' do
      let(:opportunity_response) { build(:lever_opportunity_response, :archived) }
      subject { opportunity.rejected? }

      context 'when not a hired reason' do
        before { expect(opportunity).to receive(:hired_archive_reason?).and_return((false))}
        it { is_expected.to eql(true) }
      end

      context 'when a hired reason' do
        before { expect(opportunity).to receive(:hired_archive_reason?).and_return((true))}
        it { is_expected.to eql(false) }
      end
    end

    context 'when archived is empty' do
      subject { opportunity.rejected? }
      it { is_expected.to eql(false) }
    end
  end
end
