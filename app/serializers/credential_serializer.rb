class CredentialSerializer < ActiveModel::Serializer
  attributes :id, :password, :key, :account_number, :initials, :name
end
