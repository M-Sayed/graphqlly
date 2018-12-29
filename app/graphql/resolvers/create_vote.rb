class Resolvers::CreateVote < GraphQL::Function
  argument :link_id, !types.ID

  type Types::VoteType

  def call(obj, args, ctx)
    Vote.create!(
      link: Link.find_by(id: args[:link_id]),
      user: ctx[:current_user]
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
