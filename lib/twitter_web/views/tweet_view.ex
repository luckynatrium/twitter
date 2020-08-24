defmodule TwitterWeb.TweetsView do
  use TwitterWeb, :view

  def render("index.json", %{tweets: tweets}) do
    render_many(tweets, __MODULE__, "show.json", as: :tweet)
  end

  def render("index.json", %{replies: replies}) do
    render_many(replies, __MODULE__, "show.json", as: :tweet)
  end

  def render("show.json", %{tweet: tweet}) do
    %{
      id: tweet.id,
      text: tweet.text,
      inserted_at: tweet.inserted_at
    }
  end
end
