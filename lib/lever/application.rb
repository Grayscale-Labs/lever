

module Lever
  class Application < Base
    property :id 
    property :type
    property :candidate_id, from: :candidateId
    property :opportunity_id, from: :opportunityId
    property :posting_id, from: :posting
    property :posting_hiring_manager, from: :postingHiringManager
    property :posting_owner, from: :postingOwner
    property :name
    property :company
    property :phone
    property :email
    property :links
    property :comments
    property :user
    property :custom_question, from: :customQuestions
    property :created_at, from: :createdAt
    property :archived
    property :requisition_for_hire, from: :requisitionForHire
  
    def posting
      fetch('postings', posting_id)
    end
  end
end
