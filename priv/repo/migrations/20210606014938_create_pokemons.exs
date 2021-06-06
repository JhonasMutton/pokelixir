defmodule Pokelixir.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :type, :string

      timestamps()
    end

  end
end
