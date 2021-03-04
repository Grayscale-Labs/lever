# frozen_string_literal: true

require 'active_support/core_ext/kernel/reporting'

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

    context 'when given additional query_params' do
      let(:limit) { 1 } # Use limit: 1 to limit data size + test pagination
      let(:method_args) { { limit: limit } }

      let!(:stage_responses) {
        [
          build(:lever_stage_responses_first_page, stub_request: true),
          build(:lever_stage_responses_last_page,  stub_request: true)
        ]
      }

      subject(:stages) { client.stages(method_args) }

      it 'returns a response' do
        expect(stages).to_not be_nil
      end

      it 'returns a StageCollection instance' do
        expect(stages).to be_an_instance_of(Lever::StageCollection)
      end

      it 'returns stage details' do
        expect(stages.first).to respond_to(:text)
      end

      it 'iterates by utilizing pagination' do
        expect(
          stages.first(limit * 2).map(&:id)
        ).to(
          eq(stage_responses.map { |r| r['data'].first['id'] })
        )
      end

      context do
        before(:each) do
          allow(Lever::Client).to receive(:get).and_return(double('success?': false, headers: {}, code: code))
        end

        context 'when rate-limiting encountered' do
          let(:code) { 429 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { stages.first }
          end
        end

        context 'when 500 encountered' do
          let(:code) { 500 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { stages.first }
          end
        end

        context 'when 503 encountered' do
          let(:code) { 503 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { stages.first }
          end
        end
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

    context 'when given additional query_params' do
      let(:limit) { 1 } # Use limit: 1 to limit data size + test pagination
      let(:method_args) { { posting_id: 'space-explorer', limit: limit } }

      let!(:opportunity_responses) {
        [
          build(:lever_opportunity_responses_for_posting_first_page, stub_request: true),
          build(:lever_opportunity_responses_for_posting_last_page,  stub_request: true)
        ]
      }

      subject(:opportunities) { client.opportunities(method_args) }

      it 'returns a response' do
        expect(opportunities).to_not be_nil
      end

      it 'returns an OpportunityCollection instance' do
        expect(opportunities).to be_an_instance_of(Lever::OpportunityCollection)
      end

      it 'returns opportunity details' do
        expect(opportunities.first).to respond_to(:application_data)
      end

      it 'iterates by utilizing pagination' do
        expect(
          opportunities.first(limit * 2).map(&:id)
        ).to(
          eq(opportunity_responses.map { |r| r['data'].first['id'] })
        )
      end

      context do
        before(:each) do
          allow(Lever::Client).to receive(:get).and_return(double('success?': false, headers: {}, code: code))
        end

        context 'when rate-limiting encountered' do
          let(:code) { 429 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { opportunities.first }
          end
        end

        context 'when 500 encountered' do
          let(:code) { 500 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { opportunities.first }
          end
        end

        context 'when 503 encountered' do
          let(:code) { 503 }

          it 'retries' do
            expect(client).to(receive(:get_resource)).thrice.and_call_original
            suppress(Lever::Error) { opportunities.first }
          end
        end
      end
    end

    context 'when not successful' do
      context 'when error block' do
        it 'runs the block' do
          stub_request(:get, "https://api.lever.co/v1/opportunities/1234-5678-91011?expand=applications&expand=stage").
            to_return(status: 403, body: { 'data': '' }.to_json, headers: { 'Content-Type' => 'application/json' } )

          @blah = false
          client.opportunities(id: '1234-5678-91011', on_error: ->(response) { @blah = true })
          expect(@blah).to eql(true)
        end
      end

      context 'when no error block' do
        let(:response_double) { instance_double(HTTParty::Response, body: 'response_body', code: code) }
        before do
          expect(client.class).to receive(:get).and_return(response_double)
          expect(response_double).to receive(:success?)
        end

        # context 'when 301' do
        #   let(:code) { 301 }
        #   it 'does something' do
        #     client.opportunities
        #   end
        # end

        context 'when 400' do
          let(:code) { 400 }
          it 'raises InvalidRequestError' do
            expect { client.opportunities }.to raise_error(Lever::InvalidRequestError)
          end
        end

        context 'when 401' do
          let(:code) { 401 }
          it 'raises UnauthorizedError' do
            expect { client.opportunities }.to raise_error(Lever::UnauthorizedError)
          end
        end

        context 'when 403' do
          let(:code) { 403 }
          it 'raises ForbiddenError' do
            expect { client.opportunities }.to raise_error(Lever::ForbiddenError)
          end
        end

        context 'when 404' do
          let(:code) { 404 }
          it 'raises NotFoundError' do
            expect { client.opportunities }.to raise_error(Lever::NotFoundError)
          end
        end
        context 'when 429' do
          let(:code) { 429 }
          it 'raises TooManyRequestsError' do
            expect { client.opportunities }.to raise_error(Lever::TooManyRequestsError)
          end
        end
        context 'when 500' do
          let(:code) { 500 }
          it 'raises ServerError' do
            expect { client.opportunities }.to raise_error(Lever::ServerError)
          end
        end
        context 'when 503' do
          let(:code) { 503 }
          it 'raises ServiceUnavailableError' do
            expect { client.opportunities }.to raise_error(Lever::ServiceUnavailableError)
          end
        end

        context 'when not listed' do
          let(:code) { 999 }
          it 'raises Error' do
            expect { client.opportunities }.to raise_error(Lever::Error)
          end
        end
      end
    end
  end

  describe '#interviews' do
    context 'when ID provided' do
      let!(:interview_response) { build(:lever_interview_response, id: '1234-5678-910-11', opportunity_id: 'oppo-1234', stub_request: true) }
      subject { client.interviews(id: '1234-5678-910-11', opportunity_id: 'oppo-1234' ) }

      it { is_expected.to be_a(Lever::Interview) }
    end

    context 'when no ID provided' do
      let!(:lever_interview_responses) { build(:lever_interview_responses, opportunity_id: 'oppo-1234', stub_request: true) }
      subject { client.interviews(opportunity_id: 'oppo-1234') }

      it { is_expected.to be_a(Array) }
      it { is_expected.to all(be_a(Lever::Interview)) }
    end
  end

end
