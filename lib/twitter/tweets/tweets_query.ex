defmodule Twitter.Tweets.TweetsQuery do
  alias Twitter.Repo
  alias Twitter.Tweets.Tweet
  alias Twitter.Accounts.User

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

  @spec add_likes(any, any) :: any
  def add_likes(tweet_id, user_id) do
    with tweet <- Repo.get!(Tweet, tweet_id) do
      save_likes_sender tweet, user_id
    end

  end

  def save_likes_sender(tweet, user_id) do
    user = Repo.get!(User, user_id)
    tweet
    |> Repo.preload([:replies, :liked_by])
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:liked_by, [user])
    |> Repo.update!()
  end

  def number_of_likes(tweet) do
      Repo.one(
        from(l in "likes",
          where: [tweet_id: ^tweet.id],
          select: count(l.id)
        )
      )

  end

end
