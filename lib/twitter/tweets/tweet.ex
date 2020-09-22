defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User
  alias Twitter.Tweets.Like
  alias Twitter.Tweets.Tweet

  @required [:text, :user_id]
  @optional [:parent_id]

  schema "tweets" do
    field :text, :string
    field :parent_id, :integer
    field :likes_amount, :integer, virtual: true

    has_many :replies, Tweet, foreign_key: :parent_id

    has_many :likes, Like, foreign_key: :tweet_id

    belongs_to :user, User

    timestamps()
  end

  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:parent_id)
  end

end
