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

    context 'when headers provided' do
      it 'sets them in the options' do
        client = described_class.new('1234', { headers: { 'Extra-Header' => 'Header-Value' }})

        expect(client.options[:headers]).to include({ 'Extra-Header' => 'Header-Value' })
      end
    end
  end

  describe '#hired_archive_reasons' do
    let!(:archive_reasons) { build(:lever_hired_archive_reasons_response, stub_request: true) }
    subject { client.hired_archive_reasons }

    it 'returns an array of archived reasons' do
      expect(subject).to be_a(Array)
      expect(subject).to all(be_a(Lever::ArchiveReason))
    end

    it 'can be mapped over id' do
      expect(subject.map(&:id)).to be_a(Array)
    end
  end

  describe '#stages' do
    context "when singular record" do
      let!(:stage_response) { build(:lever_stage_response, id: '1234', stub_request: true)}

      it 'returns a stage object' do
        expect(client.stages(id: "1234")).to be_a(Lever::Stage)
      end
    end
  end

  describe '#opportunities' do
    let!(:opportunity_response) { build(:lever_opportunity_response, id: '1234-5678-91011', stub_request: true) }
    let!(:opportunity_responses) { build(:lever_opportunity_responses, stub_request: true) }

    context 'when single ID provided' do
      it 'retrieves one record as an object' do
        expect(client.opportunities(id: '1234-5678-91011')).to be_a(Lever::Opportunity)
      end
    end

    context 'when no ID' do
      it 'retreives a set of records' do
        expect(client.opportunities).to all(be_a(Lever::Opportunity))
      end
    end

    context 'when filtering by contact_id' do
      let!(:opportunity_responses) { build(:lever_opportunity_responses_for_contact, contact_id: '4567', stub_request: true) }

      it 'retrieves opps for that contact' do
        expect(client.opportunities(contact_id: '4567')).to all(be_a(Lever::Opportunity))
      end
    end

    context 'on error' do
      it 'runs the block' do
        stub_request(:get, "https://api.lever.co/v1/opportunities/1234-5678-91011?expand=applications&expand=stage").
          to_return(status: 403, body: { 'data': '' }.to_json, headers: { 'Content-Type' => 'application/json' } )

        @blah = false
        client.opportunities(id: '1234-5678-91011', on_error: ->(response) { @blah = true })
        expect(@blah).to eql(true)
      end
    end
  end

end
