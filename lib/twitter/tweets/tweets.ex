defmodule Twitter.Tweets do
  alias Twitter.Tweets.TweetsQuery
  alias Twitter.Tweets.LikesQuery
  require Logger

  def create_tweet(attrs), do: TweetsQuery.create(attrs)
  def recent_tweets(), do: TweetsQuery.recent()

  def get_replies(params), do: String.to_integer(params["tweets_id"]) |> TweetsQuery.replies()

  def create_like(attrs), do: LikesQuery.create(attrs)

  def liked_tweets(user_id), do: LikesQuery.get_liked_tweets(user_id)

end
