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

end