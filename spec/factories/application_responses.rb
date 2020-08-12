require 'factory_bot'
# require "rspec/mocks/standalone"

FactoryBot.define do
  factory :lever_application_response, parent: :lever_api_response do
    id { "73731536-438d-4255-8960-d013ffd85db3" }
    type { "user" }

    # "candidateId": "8bd304b4-b8e7-41cd-bca8-607be2544325",
    # "opportunityId": "8bd304b4-b8e7-41cd-bca8-607be2544325",
    posting { "685dd0f3-6b95-4bc9-ae32-658b808900ca" }

    postingHiringManager { nil }
    postingOwner { "c895b832-820c-4f93-b873-23d5c8443acd" }
    name { nil }
    company { nil }
    phone { nil }
    email { nil }
    links { [] }
    comments { nil }
    user { "c895b832-820c-4f93-b873-23d5c8443acd" }
    customQuestions { [] }
    createdAt { 1578336284203 }
    archived { nil }
    requisitionForHire { nil }
  end
end
