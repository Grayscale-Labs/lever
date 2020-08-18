RSpec.describe Lever::Interview do
  let(:interview) { described_class.new(build(:lever_interview_response)) }
  
  describe '#initialize' do
    it "works" do
      interview
    end
  end

  describe '#subject' do
    subject { interview.subject }
    it { is_expected.to eql("On-site interview - Kristoff Bjorgman - Office Manager") }
  end

  describe '#canceled?' do
    subject { interview.canceled? }

    context 'when canceled_at is not nil' do
      before { interview.canceled_at = Time.now }
      it { is_expected.to eql(true) }
    end
  
    context 'when canceled_at is nil' do
      it { is_expected.to eql(false) }
    end
  end

  describe '#team' do
    subject { interview.team }
    it { is_expected.to be_a(Array) }
    it { is_expected.to include('Rachel Green') }
  end

  describe '#canceled_at' do
    subject { interview.canceled_at }
    context 'when is nil' do
      it { is_expected.to be_nil }
    end
    context 'when not nil' do
      let(:interview) { described_class.new(build(:lever_interview_response, :canceled)) }

      it { is_expected.to be_a(Time) }
    end
  end

end
