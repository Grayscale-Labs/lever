require 'factory_bot'

FactoryBot.define do
  factory :lever_archive_reason_response, parent: :lever_api_response do
    id { '63dd55b2-a99f-4e7b-985f-22c7bf80ab42' }
    text { 'Underqualified' }
  end

  factory :lever_hired_archive_reasons_response, parent: :lever_api_response do
    transient do
      resource_path { 'archive_reasons?type=hired'}
      use_data { false }
    end

    data do
      [
        {
          "id": "d8335f7f-ccd3-4a60-8e0a-6c114266e8eb",
          "text": "Hired"
        }
      ]
    end
  end
end
