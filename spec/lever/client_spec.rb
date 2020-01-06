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
    let(:single_result_body) {
      {
        "id": "8bd304b4-b8e7-41cd-bca8-607be2544325",
        "name": "Steve Rodgers",
        "contact": "9a2c1f5f-8720-488a-a61d-207a78db37b9",
        "headline": "Avengers",
        "stage": "lead-new",
        "location": "",
        "phones": [],
        "emails": [],
        "links": [],
        "archived": nil,
        "tags": [
          "Super Hero",
        ],
        "sources": [
          "Added manually"
        ],
        "stageChanges": [
          {
            "toStageId": "lead-new",
            "toStageIndex": 0,
            "updatedAt": 1578336284202,
            "userId": "c895b832-820c-4f93-b873-23d5c8443acd"
          }
        ],
        "origin": "sourced",
        "owner": "c895b832-820c-4f93-b873-23d5c8443acd",
        "followers": [
          "c895b832-820c-4f93-b873-23d5c8443acd"
        ],
        "applications": [
          "73731536-438d-4255-8960-d013ffd85db3"
        ],
        "createdAt": 1578336284202,
        "lastInteractionAt": 1578336284204,
        "lastAdvancedAt": 1578336284202,
        "snoozedUntil": nil,
        "urls": {
          "list": "https://hire.sandbox.lever.co/opportunities",
          "show": "https://hire.sandbox.lever.co/opportunities/8bd304b4-b8e7-41cd-bca8-607be2544325"
        },
        "isAnonymized": false,
        "dataProtection": nil
      }
    }

    before do
      @single_request = stub_request(:get, "https://api.lever.co/v1/opportunities/1234-5678-91011").
         with(
           headers: {
       	    'Accept'=>'*/*',
       	    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	    'Authorization'=>'Basic MTIzNDo=',
       	    'User-Agent'=>'Ruby'
           }
          ).to_return(status: 200, body: { 'data': single_result_body }.to_json, headers: { 'Content-Type' => 'application/json' } )

      @multiple_request = stub_request(:get, "https://api.lever.co/v1/opportunities").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic MTIzNDo=',
            'User-Agent'=>'Ruby'
          }
          ).to_return(status: 200, body: { 'data': [single_result_body, single_result_body] }.to_json, headers: { 'Content-Type' => 'application/json' } )
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