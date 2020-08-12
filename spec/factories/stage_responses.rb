require 'factory_bot'

FactoryBot.define do
  factory :lever_stage_response, parent: :lever_api_response do
    transient do
      resource_path { "stages/#{id}" }
    end

    id { 'lead-new' }
    text { 'New lead' }
  end
end
