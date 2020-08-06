module Payloads
  APPLICATION = {
    "id": "73731536-438d-4255-8960-d013ffd85db3",
    "type": "user",
    "candidateId": "8bd304b4-b8e7-41cd-bca8-607be2544325",
    "opportunityId": "8bd304b4-b8e7-41cd-bca8-607be2544325",
    "posting": "685dd0f3-6b95-4bc9-ae32-658b808900ca",
    "postingHiringManager": nil,
    "postingOwner": "c895b832-820c-4f93-b873-23d5c8443acd",
    "name": nil,
    "company": nil,
    "phone": nil,
    "email": nil,
    "links": [],
    "comments": nil,
    "user": "c895b832-820c-4f93-b873-23d5c8443acd",
    "customQuestions": [],
    "createdAt": 1578336284203,
    "archived": nil,
    "requisitionForHire": nil
  }

  POSTING = {
    "id": "685dd0f3-6b95-4bc9-ae32-658b808900ca",
    "text": "Super Hero",
    "state": "internal",
    "distributionChannels": nil,
    "user": "c895b832-820c-4f93-b873-23d5c8443acd",
    "owner": "c895b832-820c-4f93-b873-23d5c8443acd",
    "hiringManager": nil,
    "categories": {
      "commitment": nil,
      "department": nil,
      "level": nil,
      "location": "Atlanta, GA",
      "team": "Engineering"
    },
    "tags": [],
    "content": {
      "description": "",
      "descriptionHtml": "",
      "lists": [],
      "closing": "",
      "closingHtml": "",
      "customQuestions": []
    },
    "followers": [
      "c895b832-820c-4f93-b873-23d5c8443acd"
    ],
    "reqCode": nil,
    "requisitionCodes": [],
    "urls": {
      "list": "https://jobs.sandbox.lever.co/grayscaleapp",
      "show": "https://jobs.sandbox.lever.co/grayscaleapp/685dd0f3-6b95-4bc9-ae32-658b808900ca",
      "apply": "https://jobs.sandbox.lever.co/grayscaleapp/685dd0f3-6b95-4bc9-ae32-658b808900ca/apply"
    },
    "createdAt": 1578336004355,
    "updatedAt": 1578336004355
  }

  STAGE = {
    "id": "lead-new",
    "text": "New lead"
  }
  OPPORTUNITY = {
    "id": "74fd168f-1505-4d2e-afd4-6daf29bbc3a9",
    "name": "Tony Stark",
    "contact": "34a0feff-d892-48ef-b908-a0b54fe09fe1",
    "headline": "",
    "stage": STAGE,
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
    "applications": [
      APPLICATION
    ],
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

  INTERVIEW = {
    "id": "6ff55c8e-fe04-4eb4-835a-630b1c0da421",
    "panel": "fdb313e8-13c5-47de-9e51-6a21a4d76ff6",
    "subject": "On-site interview - Kristoff Bjorgman - Office Manager",
    "note": "SCHEDULE:\n6:00 - 6:30 pm - Rachel Green - Call - (123) 456-7891\n",
    "interviewers": [
      {
        "email": "rachel@exampleq3.com",
        "id": "412f5bf5-1509-4916-ba5b-8b16a5c3ce6d",
        "name": "Rachel Green"
      }
    ],
    "timezone": "America/Los_Angeles",
    "createdAt": 1423187000000,
    "date": 1423188000000,
    "duration": 30,
    "location": "Call - (123) 456-7891",
    "feedbackTemplate": "7fdd449e-0bb1-4ac8-9b96-9281c1dc2099",
    "feedbackForms": [
      "0a96e6ca-2f17-4046-87b3-15d3b6a148db"
    ],
    "feedbackReminder": "once",
    "user": "e434f554-659d-462d-abeb-943b9deaa370",
    "stage": "f709f65a-481f-4067-9a0d-934a79da9f8e",
    "canceledAt": nil,
    "postings": [
      "9026d1f1-a03b-49dc-8a17-5f448d1de52b"
    ]
  }

  CANCELED_INTERVIEW = INTERVIEW.merge({ 'canceledAt' => Time.now })

end
