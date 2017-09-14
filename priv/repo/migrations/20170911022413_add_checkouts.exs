defmodule FelloAc.Repo.Migrations.AddCheckouts do
  use Ecto.Migration

  def change do
    create table(:checkouts) do
      add :email, :string
      add :device, :string
      add :item, :string

      timestamps()
    end
  end
end
