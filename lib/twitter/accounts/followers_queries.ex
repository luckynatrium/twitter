defmodule Twitter.Accounts.User.FollowersQuery do

  alias Twitter.Repo
  alias Twitter.Accounts.User.Follower
  alias Twitter.Tweets.Tweet
  alias Twitter.Tweets.TweetsQuery

  import Ecto.Query

  def create(attrs \\ %{}) do
    %Follower{}
    |> Follower.changeset(attrs)
    |> Repo.insert()
  end

  def get_followees_tweets(user_id) do
      query =
        from tw in Tweet,
        join: f in Follower,
        on: tw.user_id == f.user_id,
        where: f.follower_id == ^user_id,
        join: l in assoc(tw, :likes),
        order_by: [desc: tw.inserted_at]
        
      query |> TweetsQuery.add_likes_amount |> Repo.all()

  end

end
