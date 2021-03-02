require 'lever/base'

module Lever
  class Posting < Base
    property :id
    property :text
    property :state
    property :distribution_channels, from: :distributionChannels
    property :user
    property :owner
    property :hiring_manager, from: :hiringManager
    property :categories
    property :tags
    property :content
    property :followers
    property :req_code, from: :reqCode
    property :requisition_codes, from: :requisitionCodes
    property :urls
    property :created_at, from: :createdAt
    property :updated_at, from: :updatedAt
  end
end
