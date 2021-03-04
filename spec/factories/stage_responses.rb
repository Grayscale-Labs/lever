require 'factory_bot'

FactoryBot.define do
  factory :lever_stage_response, parent: :lever_api_response do
    transient do
      resource_path { "stages/#{id}" }
    end

    id { 'lead-new' }
    text { 'New lead' }
  end

  factory :lever_stage_responses_first_page, parent: :lever_api_response do
    transient do
      resource_path { 'stages?limit=1' }
      use_data { false }
    end

    data { create_list(:lever_stage_response, 1) }
    add_attribute(:next) { 'one-million' }
    hasNext { true }
  end

  factory :lever_stage_responses_last_page, parent: :lever_api_response do
    transient do
      resource_path { 'stages?limit=1&offset=one-million' }
      use_data { false }
    end

    data { create_list(:lever_stage_response, 1) }
    hasNext { false }
  end
end
