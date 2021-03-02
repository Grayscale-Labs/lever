require 'lever/base'

module Lever
  class Interview < Base
    property :id
    property :subject
    property :note
    property :panel
    property :timezone
    property :created_at, from: :createdAt, with: ->(value) { Time.at(value) }
    property :canceled_at, from: :canceledAt, with: ->(value) { Time.at(value) if value }
    property :date
    property :duration
    property :location
    property :interviewers_data, from: :interviewers

    property :stage
    property :user

    def interviewers
      interviewers_data.map { |data| Lever::User.new(data.merge(client: client)) }
    end

    def team
      interviewers_data.map { |data| data['name'] }
    end

    def canceled?
      !canceled_at.nil?
    end
  end
end
