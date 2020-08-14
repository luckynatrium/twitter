defmodule Twitter.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table :users do
      add :email, :string, null: false, unique: true
      add :password_hash, :string, null: false
      add :username, :string, null: false, unique: true
      add :name, :string
      add :bio, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
