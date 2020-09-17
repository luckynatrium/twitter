defmodule Twitter.Tweets.LikesQuery do

  import Ecto.Query

  alias Twitter.Repo
  alias Twitter.Tweets.Like
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
      group_by: t.id,
      select_merge: %{likes_amount: count(l.id)}
    Repo.all(query)
  end


end
