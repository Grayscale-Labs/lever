RSpec.describe Lever::Base do
  
  describe '#hired_archive_reason?' do
    context 'when unauthorized access to hired archive reasons' do
      let(:base) { described_class.new }
      let(:client_double) { instance_double(Lever::Client) }
      before do
        expect(base).to receive(:client).and_return(client_double)
        allow(client_double).to receive(:hired_archive_reasons).and_raise(Lever::ForbiddenError.new(403))
      end
      it 'is false' do
        expect(base.hired_archive_reason?('1234')).to eql(false)
      end
    end
  end
end
