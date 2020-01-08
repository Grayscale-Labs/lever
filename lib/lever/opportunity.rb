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
    property :applications, transform_with: lambda { |values| values.map { |application_data| Lever::Application.new(application_data) } }
    property :created_at, from: :createdAt
    property :last_interaction_at, from: :lastInteractionAt
    property :last_advanced_at, from: :lastAdvancedAt
    property :snoozed_until, from: :snoozedUntil
    property :urls
    property :is_anonymized, from: :isAnonymized
    property :data_protection, from: :dataProtection
  end
end