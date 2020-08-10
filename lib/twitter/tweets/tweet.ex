defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User

  @required [:text, :user_id]
  @optional []

  schema "tweets" do
    field :text, :string
    field :parent_id, :integer

    has_many :replies, Twitter.Tweets.Tweet, foreign_key: :parent_id

    belongs_to :user, User

    timestamps()
  end

  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:parent_id)
  end


end
