Types::AuthProviderPasswordsInput = GraphQL::InputObjectType.define do
  name 'AuthProviderPasswordsInput'

  argument :password, !types.String
  argument :password_confirmation, !types.String
end
