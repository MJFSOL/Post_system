# app/graphql/types/user_type.rb
module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: false
    field :business_name, String, null: true
    field :business_address, String, null: true
    field :phone, String, null: true
    field :role, String, null: false
  end
end