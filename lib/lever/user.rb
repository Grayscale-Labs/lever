require 'lever/base'

module Lever
  class User < Base
    property :id
    property :name
    property :username
    property :email
    property :photo
    property :access_role, from: :accessRole
    property :created_at, from: :createdAt
    property :deactivated_at, from: :deactivatedAt
    property :external_directory_id, from: :externalDirectoryId
  end
end
