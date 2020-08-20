require 'factory_bot'

FactoryBot.define do
  factory :lever_api_response, class: Hash do
    skip_create
    initialize_with { attributes.deep_stringify_keys }

    transient do
      stub_request { false }
      api_base { 'https://api.lever.co/v1' }
      resource_path { raise "You must define the resource url in the factory" if stub_request }
      use_data { true }
      status { 200 }
    end

    after(:build) do |api_response, evaluator|
      if evaluator.stub_request
        url = [evaluator.api_base, evaluator.resource_path].join('/')
        response_body = evaluator.use_data ? { data: api_response } : api_response

        WebMock.
          stub_request(:get, url).
            to_return(
              status: evaluator.status,
              body: response_body.to_json,
              headers: { 'Content-Type' => 'application/json' }
            )
      end
    end
  end
end
