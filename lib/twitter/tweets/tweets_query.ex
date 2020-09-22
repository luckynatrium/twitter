defmodule Twitter.Tweets.TweetsQuery do
  alias Twitter.Repo
  alias Twitter.Tweets.Tweet


  import Ecto.Query

  def create(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
  end

  def recent() do
    query =
      from tweet in Tweet,
      order_by: [desc: tweet.inserted_at]
    query
    |> add_likes_amount
    |> Repo.all
  end

  def replies(tweet_id) do
    query =
      from tw in Tweet,
      where: ^tweet_id == tw.parent_id
    query
    |> add_likes_amount
    |> Repo.all()
  end

  def add_likes_amount(query) do
    from tweet in query,
    join: l in assoc(tweet, :likes),
    group_by: tweet.id,
    select_merge: %{likes_amount: count(l.id)}
  end



end
