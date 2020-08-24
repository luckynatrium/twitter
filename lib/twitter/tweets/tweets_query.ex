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
    query = from tweet in Tweet, order_by: [desc: tweet.inserted_at]
    Repo.all(query)
  end

  def replies(tweet_id) do
    query = from tw in Tweet, where: ^tweet_id == tw.id, preload: :replies
    Repo.all(query)
  end
end
