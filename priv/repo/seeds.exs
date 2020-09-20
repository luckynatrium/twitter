# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Twitter.Repo.insert!(%Twitter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Twitter.Repo
alias Twitter.Accounts.User
alias Twitter.Tweets.Tweet
alias Twitter.Tweets.Like
alias Twitter.Accounts.User.Follower
alias Twitter.Accounts.UserQueries
alias Twitter.Tweets.TweetsQuery

UserQueries.create %{
  email: "test_user1@mail.com",
  password: "123456",
  username: "clenus"
}
UserQueries.create %{
  email: "coolmail@mail.com",
  password: "123456",
  username: "polina"
}
UserQueries.create %{
  email: "cream@mail.com",
  password: "123456",
  username: "ivan"
}

TweetsQuery.create %{
  text: "First tweet in Twitter!",
  user_id: Repo.get_by!(User, username: "clenus").id
}
TweetsQuery.create %{
  text: "Second tweet in Twitter!",
  user_id: Repo.get_by!(User, username: "polina").id
}
TweetsQuery.create %{
  text: "first tweet in Tweeter",
  user_id: Repo.get_by!(User, username: "ivan").id
}
TweetsQuery.create %{
  text: "Hey, my tweet is first tweet in Twitter",
  user_id: Repo.get_by!(User, username: "ivan").id,
  parent_id: Repo.get_by!(Tweet, text: "First tweet in Twitter!").id
}


Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "First tweet in Twitter!"),
  user_id: Repo.get_by!(User, username: "polina")
}
Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "Second tweet in Twitter!"),
  user_id: Repo.get_by!(User, username: "clenus")
}
Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "Second tweet in Twitter!"),
  user_id: Repo.get_by!(User, username: "ivan")
}

Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "polina"),
  user_id: Repo.get_by!(User, username: "clenus")
}
Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "clenus"),
  user_id: Repo.get_by!(User, username: "polina")
}
Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "ivan"),
  user_id: Repo.get_by!(User, username: "polina")
}
