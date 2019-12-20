RSpec.describe Lever::User do
  describe '#initialize' do
    it "works" do
      parsed_response = {
        "id": "74fd168f-1505-4d2e-afd4-6daf29bbc3a9",
        "name": "Tony Stark",
        "contact": "34a0feff-d892-48ef-b908-a0b54fe09fe1",
        "headline": "",
        "stage": "lead-new",
        "location": "",
        "phones": [
          {
            "type": "mobile",
            "value": "5555555555"
          },
          {
            "type": "skype",
            "value": "fsdfsf"
          }
        ],
        "emails": [
          "tony@starkenterprises.com",
        ],
        "links": [],
        "archived": nil,
        "tags": [],
        "sources": [
          "Added manually"
        ],
        "stageChanges": [
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
        ],
        "origin": "sourced",
        "owner": "c895b832-820c-4f93-b873-23d5c8443acd",
        "followers": [
          "c895b832-820c-4f93-b873-23d5c8443acd"
        ],
        "applications": [],
        "createdAt": 1567701073802,
        "lastInteractionAt": 1576703372059,
        "lastAdvancedAt": 1570734056441,
        "snoozedUntil": nil,
        "urls": {
          "list": "https://hire.sandbox.lever.co/candidates",
          "show": "https://hire.sandbox.lever.co/candidates/74fd168f-1505-4d2e-afd4-6daf29bbc3a9"
        },
        "isAnonymized": false,
        "dataProtection": nil
      }

      candidate = Lever::Candidate.new(parsed_response)
      expect(candidate.name).to eql("Tony Stark")
    end
  end
end
