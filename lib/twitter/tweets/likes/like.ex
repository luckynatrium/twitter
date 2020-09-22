defmodule Twitter.Tweets.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User
  alias Twitter.Tweets.Tweet

  @required [:user_id, :tweet_id]
  @optional []

  schema "likes" do

    belongs_to :liked, Tweet, foreign_key: :tweet_id
    belongs_to :liked_by, User, foreign_key: :user_id


    timestamps()
  end

  def changeset(like, attrs) do
   like
   |> cast(attrs, @required ++ @optional)
   |> validate_required(@required)
   |> foreign_key_constraint(:user_id)
   |> foreign_key_constraint(:tweet_id)
  end
end
