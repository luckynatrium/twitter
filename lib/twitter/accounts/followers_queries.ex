defmodule Twitter.Accounts.User.FollowersQuery do

  alias Twitter.Repo
  alias Twitter.Accounts.User.Follower
  alias Twitter.Tweets.Tweet
  alias Twitter.Tweets.TweetsQuery
  alias Twitter.Tweets.Like

  import Ecto.Query

  def create(attrs \\ %{}) do
    %Follower{}
    |> Follower.changeset(attrs)
    |> Repo.insert()
  end

  def feed(user_id) do
    user_id
    |> get_followees_tweets()
    |> union(^get_followees_liked_tweets(user_id))
    |> distinct(true)
    |> subquery()
    |> order_by([tw],desc: tw.inserted_at)
    |> Repo.all()
  end

  def get_followees_tweets(user_id) do
      query =
        from tw in Tweet,
        join: f in Follower,
        on: tw.user_id == f.user_id,
        where: f.follower_id == ^user_id,
        join: l in assoc(tw, :likes)

      query |> TweetsQuery.add_likes_amount()
  end

  def get_followees_liked_tweets(user_id) do
    query =
      from tw in Tweet,
      join: l in Like,
      on: tw.id == l.tweet_id,
      join: f in Follower,
      on: f.user_id == l.user_id,
      where: f.follower_id == ^user_id
    query |> TweetsQuery.add_likes_amount()
  end

end
