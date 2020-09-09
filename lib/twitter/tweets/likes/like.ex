defmodule Twitter.Tweets.Likes.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User

  @required [:user_id, :tweet_id]
  @optional []

  schema "likes" do

    belongs_to :liked, Twitter.Tweets.Tweet, foreign_key: :tweet_id
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
