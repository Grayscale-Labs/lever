RSpec.describe Lever::Application do
  let(:application) { Lever::Application.new(Payloads::APPLICATION) }

  describe '#initialize' do
    it "works" do
      expect(application.type).to eql("user")
    end
  end

  describe '#posting' do
    it 'grabs the posting from the api' do
      request = stub_request(:get, "https://api.lever.co/v1/postings/685dd0f3-6b95-4bc9-ae32-658b808900ca").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Basic MTIzNDo=',
          'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: { 'data': Payloads::POSTING }.to_json, headers: { 'Content-Type' => 'application/json' })

      application.client = Lever::Client.new('1234')
      expect(application.posting).to be_a(Lever::Posting)
      expect(request).to have_been_requested
    end
  end
end
