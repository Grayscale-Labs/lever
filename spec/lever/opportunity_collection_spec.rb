RSpec.describe Lever::OpportunityCollection do
  context 'with fake/ugly page of fake results' do
    let(:collection) do
      described_class.new(client: OpenStruct.new).tap do |instance|
        instance.instance_variable_set('@all_pages_requested', true)
        instance.instance_variable_set('@hydrated_resources', [1, 2, 3, 4, 5])
      end
    end

    it 'dehydrates on iteration by default' do
      collection.each do |val|
        expect(val).to be_a Numeric
      end

      collection.each do |val|
        expect(val).to eq :dehydrated
      end
    end
  end
end
