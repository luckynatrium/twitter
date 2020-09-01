defmodule Twitter.Accounts.UserQueries do

  alias Twitter.Accounts.User
  alias Twitter.Repo

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get!(User, id)
  end

  def get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      {:ok, user} -> {:ok, user}
      _ -> nil
    end
  end
  
end
