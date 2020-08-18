require 'factory_bot'

FactoryBot.define do
  factory :lever_interview_response, parent: :lever_api_response do
    transient do
      opportunity_id { }
      resource_path { "opportunities/#{opportunity_id}/interviews/#{id}" }
    end

    id { "6ff55c8e-fe04-4eb4-835a-630b1c0da421" }
    panel { "fdb313e8-13c5-47de-9e51-6a21a4d76ff6" }
    subject { "On-site interview - Kristoff Bjorgman - Office Manager" }
    note { "SCHEDULE:\n6:00 - 6:30 pm - Rachel Green - Call - (123) 456-7891\n" }
    interviewers do
      [
        {
          "email": "rachel@exampleq3.com",
          "id": "412f5bf5-1509-4916-ba5b-8b16a5c3ce6d",
          "name": "Rachel Green"
        }
      ]
    end
    timezone { "America/Los_Angeles" }
    createdAt { 1423187000000 }
    date { 1423188000000 }
    duration { 30 }
    location { "Call - (123) 456-7891" }
    feedbackTemplate { "7fdd449e-0bb1-4ac8-9b96-9281c1dc2099" }
    feedbackForms { ["0a96e6ca-2f17-4046-87b3-15d3b6a148db"] }
    feedbackReminder { "once" }
    user { "e434f554-659d-462d-abeb-943b9deaa370" }
    stage { "f709f65a-481f-4067-9a0d-934a79da9f8e" }
    canceledAt { nil }
    postings do
      [
        "9026d1f1-a03b-49dc-8a17-5f448d1de52b"
      ]
    end

    trait(:canceled) do
      canceledAt { Time.now }
    end
  end

  factory :lever_interview_responses, parent: :lever_api_response do
    transient do
      opportunity_id { }
      resource_path { "opportunities/#{opportunity_id}/interviews" }
      use_data { false }
    end

    data { create_list(:lever_interview_response, 10) }
  end
end
