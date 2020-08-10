defmodule Twitter.Tweets do
  alias Twitter.Tweets.TweetsQuery
  require Logger

  def create_tweet(attrs), do: TweetsQuery.create(attrs)
  def recent_tweets(), do: TweetsQuery.recent()

  def get_replies(params), do: String.to_integer(params["tweets_id"]) |> TweetsQuery.replies()


end
