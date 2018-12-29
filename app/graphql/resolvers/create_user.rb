class Resolvers::CreateUser < GraphQL::Function
  argument :name, !types.String
  argument :email, !types.String
  argument :authProvider, !Types::AuthProviderPasswordsInput

  type Types::UserType

  def call(obj, args, ctx)
    User.create!(
      name: args[:name],
      email: args[:email],
      password: args[:authProvider][:password],
      password_confirmation: args[:authProvider][:password_confirmation]
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
