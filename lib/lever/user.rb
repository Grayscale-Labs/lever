require 'hashie'

module Lever
  class User < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
  
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