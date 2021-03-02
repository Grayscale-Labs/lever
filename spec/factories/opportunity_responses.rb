require 'factory_bot'

FactoryBot.define do
  factory :lever_opportunity_response, parent: :lever_api_response do
    transient do
      resource_path { "opportunities/#{id}?expand=applications&expand=stage" }
    end

    id { "74fd168f-1505-4d2e-afd4-6daf29bbc3a9" }
    name { "Tony Stark" }
    contact { "34a0feff-d892-48ef-b908-a0b54fe09fe1" }
    headline { "" }
    stage { association(:lever_stage_response) }
    location { "" }
    phones do
      [
        {
          "type": "mobile",
          "value": "5555555555"
        },
        {
          "type": "skype",
          "value": "fsdfsf"
        }
      ]
    end
    emails { ["tony@starkenterprises.com"] }
    links { [] }
    archived { nil }
    tags { [] }
    sources { ["Added manually"] }
    stageChanges do
      [
        {
          "toStageId": "lead-new",
          "toStageIndex": 0,
          "updatedAt": 1567701073802,
          "userId": "c895b832-820c-4f93-b873-23d5c8443acd"
        },
        {
          "toStageId": "lead-reached-out",
          "toStageIndex": 1,
          "updatedAt": 1568739297141,
          "userId": "2db913b1-82ff-4ecb-b762-3125bf73719f"
        },
        {
          "toStageId": "lead-new",
          "toStageIndex": 0,
          "updatedAt": 1570734056441,
          "userId": "2db913b1-82ff-4ecb-b762-3125bf73719f"
        }
      ]
    end
    origin { "sourced" }
    owner { "c895b832-820c-4f93-b873-23d5c8443acd" }
    followers do
      [
       "c895b832-820c-4f93-b873-23d5c8443acd"
      ]
    end
    applications { [association(:lever_application_response)] }
    createdAt { 1567701073802 }
    lastInteractionAt { 1576703372059 }
    lastAdvancedAt { 1570734056441 }
    snoozedUntil { nil }
    urls do
      {
        "list": "https://hire.sandbox.lever.co/candidates",
        "show": "https://hire.sandbox.lever.co/candidates/74fd168f-1505-4d2e-afd4-6daf29bbc3a9"
      }
    end
    isAnonymized { false }
    dataProtection { nil }

    trait(:archived) do
      archived do
        {
          archivedAt: 1417588008760,
          reason: '63dd55b2-a99f-4e7b-985f-22c7bf80ab42'
        }
      end
    end
  end

  factory :lever_opportunity_responses, parent: :lever_api_response do
    transient do
      resource_path { 'opportunities' }
      use_data { false }
    end

    data { create_list(:lever_opportunity_response, 10) }
  end

  factory :lever_opportunity_responses_for_contact, parent: :lever_api_response do
    transient do
      contact_id { 'contact-1234' }
      resource_path { "opportunities?contact_id=#{contact_id}" }
      use_data { false }
    end

    data { create_list(:lever_opportunity_response, 10) }
  end

  factory :lever_opportunity_responses_for_posting_first_page, parent: :lever_api_response do
    transient do
      resource_path { 'opportunities?limit=1&posting_id=space-explorer' }
      use_data { false }
    end

    data { create_list(:lever_opportunity_response, 1) }
    add_attribute(:next) { 'one-million' }
    hasNext { true }
  end

  factory :lever_opportunity_responses_for_posting_last_page, parent: :lever_api_response do
    transient do
      resource_path { 'opportunities?limit=1&posting_id=space-explorer&offset=one-million' }
      use_data { false }
    end

    data { create_list(:lever_opportunity_response, 1) }
    hasNext { false }
  end
end
