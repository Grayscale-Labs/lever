RSpec.describe Lever::Application do
  let(:application_response) { build(:lever_application_response) }
  let(:application) { Lever::Application.new(application_response) }

  describe '#initialize' do
    it "sets the type" do
      expect(application.type).to eql(application_response['type'])
    end

    it 'sets the id' do
      expect(application.id).to eql(application_response['id'])
    end

    it 'sets the posting_id' do
      expect(application.posting_id).to eql(application_response['posting'])
    end
  end

  describe '#posting' do
    let!(:posting_response) { build(:lever_posting_response, stub_request: true) }
    it 'grabs the posting from the api' do
      application.client = Lever::Client.new('1234')
      expect(application.posting).to be_a(Lever::Posting)
    end
  end
end
