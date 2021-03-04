require 'factory_bot'

FactoryBot.define do
  factory :lever_posting_response, parent: :lever_api_response do
    transient do
      resource_path { "postings/#{id}" }
    end

    id { "685dd0f3-6b95-4bc9-ae32-658b808900ca" }
    text { "Super Hero" }
    state { "internal" }
    distributionChannels { nil }
    user { "c895b832-820c-4f93-b873-23d5c8443acd" }
    owner { "c895b832-820c-4f93-b873-23d5c8443acd" }
    hiringManager { nil }
    categories do
      {
        "department": "DevOps",
        "location": "Atlanta, GA",
        "team": "Engineering"
      }
    end

    # "tags": [],
    # "content": {
    #   "description": "",
    #   "descriptionHtml": "",
    #   "lists": [],
    #   "closing": "",
    #   "closingHtml": "",
    #   "customQuestions": []
    # },
    # "followers": [
    #   "c895b832-820c-4f93-b873-23d5c8443acd"
    # ],
    # "reqCode"nil,
    # "requisitionCodes"[],
    # "urls": {
    #   "list": "https://jobs.sandbox.lever.co/grayscaleapp",
    #   "show": "https://jobs.sandbox.lever.co/grayscaleapp/685dd0f3-6b95-4bc9-ae32-658b808900ca",
    #   "apply": "https://jobs.sandbox.lever.co/grayscaleapp/685dd0f3-6b95-4bc9-ae32-658b808900ca/apply"
    # },
    # "createdAt": 1578336004355,
    # "updatedAt": 1578336004355
  end
end
