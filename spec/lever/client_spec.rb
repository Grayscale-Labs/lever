RSpec.describe Lever::Client do
  
  describe '#initialize' do
    context 'when sandbox' do
      it 'sets the right base_uri' do
        expect(Lever::Client.new('1234', { sandbox: true }).base_uri).to eql('https://api.sandbox.lever.co/v1')
      end
    end

    it 'sets the right base_uri' do
      expect(Lever::Client.new('1234').base_uri).to eql('https://api.lever.co/v1')
    end
  end

end