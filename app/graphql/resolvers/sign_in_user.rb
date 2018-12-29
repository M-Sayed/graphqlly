class Resolvers::SignInUser < GraphQL::Function
  argument :email,    !types.String
  argument :password, !types.String

  type do
    name 'signInPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(obj, args, ctx)
    return unless args[:email] && args[:password]

    user = User.find_by email: args[:email]

    return unless user && user.authenticate(args[:password])

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    ctx[:session][:token] = token

    OpenStruct.new({
      user: user,
      token: token
    })
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
