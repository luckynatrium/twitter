defmodule Twitter.Accounts.Follower do

  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User

  @required [:user_id, :follower_id]

  schema "followers" do

    belongs_to :follower, User, foreign_key: :follower_id
    belongs_to :followee, User, foreign_key: :user_id

    timestamps()
  end

  def changeset(follower, attrs) do
    follower
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:follower_id)
  end

end
