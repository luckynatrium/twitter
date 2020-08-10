defmodule Twitter.Accounts.UserQueries do

  alias Twitter.Accounts.User
  alias Twitter.Repo

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end


end
