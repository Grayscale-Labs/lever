# frozen_string_literal: true

require 'lever/base'

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
    property :created_at, from: :createdAt, with: ->(value) { Time.at(value / 1000.to_f) }
    property :last_interaction_at, from: :lastInteractionAt
    property :last_advanced_at, from: :lastAdvancedAt
    property :snoozed_until, from: :snoozedUntil
    property :urls
    property :is_anonymized, from: :isAnonymized
    property :data_protection, from: :dataProtection

    def applications
      application_data.map { |data| Lever::Application.new(data.merge(client: client)) }
    end

    def archived?
      !(archived.nil? || archived.empty?)
    end

    def hired?
      archived? && hired_archive_reason?(archived.dig('reason'))
    end

    def rejected?
      archived? && !hired_archive_reason?(archived.dig('reason'))
    end

    def stage_id
      stage && stage['id']
    end

    def stage_name
      stage && stage['text']
    end
  end
end
