defmodule Twitter.Repo.Migrations.CreateJoinTableTweetsUsers do
  use Ecto.Migration

  def change do
    create table :tweets_users do
      add :user_id, references(:users, on_delete: :delete_all)
      add :tweet_id, references(:tweets, on_delete: :delete_all)
    end
    
    create unique_index(:tweets_users, [:tweet_id, :user_id])
  end
end
