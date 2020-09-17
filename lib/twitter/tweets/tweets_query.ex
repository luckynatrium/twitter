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
      join: l in assoc(tweet, :likes),
      order_by: [desc: tweet.inserted_at],
      group_by: tweet.id,
      select_merge: %{likes_amount: count(l.id)}
    Repo.all(query)
  end

  def replies(tweet_id) do
    query =
      from tw in Tweet,
      where: ^tweet_id == tw.id,
      join: l in assoc(tw, :likes),
      preload: [:replies, :likes],
      group_by: tw.id,
      select_merge: %{likes_amount: count(tw.likes)}
    Repo.all(query)
  end



end
