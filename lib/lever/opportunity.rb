module Lever
  class Opportunity < Base
    property :id
    property :name
    property :contact
    property :headline
    property :stage
    property :location
    property :phones
    property :emails
    property :links
    property :archived
    property :tags
    property :sources
    property :stage_changes, from: :stageChanges
    property :origin
    property :owner
    property :followers
    property :application_data, from: :applications
    property :created_at, from: :createdAt
    property :last_interaction_at, from: :lastInteractionAt
    property :last_advanced_at, from: :lastAdvancedAt
    property :snoozed_until, from: :snoozedUntil
    property :urls
    property :is_anonymized, from: :isAnonymized
    property :data_protection, from: :dataProtection

    def applications
      application_data.map { |data| Lever::Application.new(data.merge(client: client)) }
    end
  end
end