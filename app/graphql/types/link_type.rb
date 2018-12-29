Types::LinkType = GraphQL::ObjectType.define do
  name "link"

  field :id, !types.ID
  field :url, !types.String
  field :description, types.String
  field :posted_by, -> { Types::UserType }, property: :user
  field :votes, -> { !types[Types::VoteType] }

end
