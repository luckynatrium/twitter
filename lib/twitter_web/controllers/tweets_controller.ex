defmodule TwitterWeb.TweetsController do
  use TwitterWeb, :controller

  alias Twitter.Tweets

  def create(conn, params) do
    with {:ok, tweet} <- Tweets.create_tweet(params) do
      render(conn, "show.json", %{tweet: tweet})
    end
  end

  def index(conn, _) do
    tweets = Tweets.recent_tweets()
    render(conn, "index.json", %{tweets: tweets})
  end

  def replies(conn, params) do
    with replies <- Tweets.get_replies(params) do
      render(conn, "index.json", %{replies: replies})
    end
  end

  def like(conn, attrs) do
    Tweets.create_like(attrs)
    render(conn,"like.json", %{})
  end

  def liked_tweets(conn, %{"user_id" => user_id}) do
    conn
    |> render("index.json", %{tweets: Tweets.liked_tweets(user_id)})
  end
end
