RSpec.describe Lever::Client do
  let(:client) { described_class.new('1234') }
  
  describe '#initialize' do
    context 'when sandbox' do
      it 'sets the right base_uri' do
        expect(Lever::Client.new('1234', { sandbox: true }).base_uri).to eql('https://api.sandbox.lever.co/v1')
      end
    end

    it 'sets the right base_uri' do
      expect(client.base_uri).to eql('https://api.lever.co/v1')
    end
  end

  describe '#opportunities' do
    before do
      @single_request = stub_request(:get, "https://api.lever.co/v1/opportunities/1234-5678-91011?expand=applications&expand=stages").
         with(
           headers: {
       	    'Accept'=>'*/*',
       	    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	    'Authorization'=>'Basic MTIzNDo=',
       	    'User-Agent'=>'Ruby'
           }
          ).to_return(status: 200, body: { 'data': Payloads::OPPORTUNITY }.to_json, headers: { 'Content-Type' => 'application/json' } )

      @multiple_request = stub_request(:get, "https://api.lever.co/v1/opportunities").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic MTIzNDo=',
            'User-Agent'=>'Ruby'
          }
          ).to_return(status: 200, body: { 'data': [Payloads::OPPORTUNITY, Payloads::OPPORTUNITY] }.to_json, headers: { 'Content-Type' => 'application/json' } )
    end

    context 'when single ID provided' do
      it 'retrieves one record as an object' do
        expect(client.opportunities('1234-5678-91011')).to be_a(Lever::Opportunity)
        expect(@single_request).to have_been_requested
      end
    end

    context 'when no ID' do
      it 'retreives a set of records' do
        expect(client.opportunities).to all(be_a(Lever::Opportunity))
        expect(@multiple_request).to have_been_requested
      end
    end
  end

end