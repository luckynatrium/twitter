defmodule Twitter.Repo.Migrations.CreateLikesTable do
  use Ecto.Migration

  def change do
    create table :likes do
      add :user_id, references(:users, on_delete: :delete_all)
      add :tweet_id, references(:tweets, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:likes, [:tweet_id, :user_id])
  end
end
