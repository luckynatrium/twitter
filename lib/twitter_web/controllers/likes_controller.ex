defmodule TwitterWeb.LikesController do
  use TwitterWeb, :controller
  alias Twitter.Tweets.Likes.LikesQuery

  def create(conn, attrs \\%{}) do
    LikesQuery.create(attrs)
    conn
    |> put_view(TwitterWeb.TweetsView)
    |> render("like.json", %{})
  end

  def liked_tweets(conn, %{"user_id" => user_id}) do
    conn
    |> put_view(TwitterWeb.TweetsView)
    |> render("index.json", %{tweets: LikesQuery.get_liked_tweets(user_id)})
  end
end
