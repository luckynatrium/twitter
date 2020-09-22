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
alias Twitter.Accounts.Follower
alias Twitter.Accounts
alias Twitter.Tweets.TweetsQuery


Accounts.create_user %{
  email: "test_user1@mail.com",
  password: "123456",
  username: "clenus"
}
Accounts.create_user %{
  email: "coolmail@mail.com",
  password: "123456",
  username: "polina"
}
Accounts.create_user %{
  email: "cream@mail.com",
  password: "123456",
  username: "ivan"
}

Repo.insert! %Tweet{
  text: "First tweet in Twitter!",
  user_id: Repo.get_by!(User, username: "clenus").id
}
Repo.insert! %Tweet{
  text: "Second tweet in Twitter!",
  user_id: Repo.get_by!(User, username: "polina").id
}
Repo.insert! %Tweet{
  text: "first tweet in Tweeter",
  user_id: Repo.get_by!(User, username: "ivan").id
}
Repo.insert! %Tweet{
  text: "Hey, my tweet was first in Twitter",
  user_id: Repo.get_by!(User, username: "ivan").id,
  parent_id: Repo.get_by!(Tweet, text: "First tweet in Twitter!").id
}


Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "First tweet in Twitter!").id,
  user_id: Repo.get_by!(User, username: "polina").id
}
Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "Second tweet in Twitter!").id,
  user_id: Repo.get_by!(User, username: "clenus").id
}
Repo.insert! %Like{
  tweet_id: Repo.get_by!(Tweet, text: "Second tweet in Twitter!").id,
  user_id: Repo.get_by!(User, username: "ivan").id
}

Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "polina").id,
  user_id: Repo.get_by!(User, username: "clenus").id
}
Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "clenus").id,
  user_id: Repo.get_by!(User, username: "polina").id
}
Repo.insert! %Follower{
  follower_id: Repo.get_by!(User, username: "ivan").id,
  user_id: Repo.get_by!(User, username: "polina").id
}
