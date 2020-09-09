defmodule Twitter.Tweets.Likes.LikesQuery do

  import Ecto.Query

  alias Twitter.Repo
  alias Twitter.Accounts.User
  alias Twitter.Tweets.Likes.Like
  alias Twitter.Tweets.Tweet

  def create(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  def get_liked_tweets(user_id) do
    query =
      from t in Tweet,
      join: l in assoc(t, :likes),
      where: l.user_id == ^user_id,
      preload: [likes: l]
    Repo.all(query)
  end

end
