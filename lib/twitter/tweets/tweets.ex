defmodule Twitter.Tweets do
  alias Twitter.Tweets.TweetsQuery
  require Logger

  def create_tweet(attrs), do: TweetsQuery.create(attrs)
  def recent_tweets(), do: TweetsQuery.recent()

  def get_replies(params), do: String.to_integer(params["tweets_id"]) |> TweetsQuery.replies()

  def like_tweet(%{"tweet_id" => tweet_id, "user_id" => user_id}), do: TweetsQuery.add_likes(tweet_id, user_id)
end
