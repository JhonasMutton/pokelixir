defmodule PokelixirWeb.PokemonController do
  use PokelixirWeb, :controller

  alias Pokelixir.Functions
  alias Pokelixir.Functions.Pokemon

  def index(conn, _params) do
    pokemons = Functions.list_pokemons()
    render(conn, "index.html", pokemons: pokemons)
  end

  def new(conn, _params) do
    changeset = Functions.change_pokemon(%Pokemon{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pokemon" => pokemon_params}) do
    case Functions.create_pokemon(pokemon_params) do
      {:ok, pokemon} ->
        conn
        |> put_flash(:info, "Pokemon created successfully.")
        |> redirect(to: Routes.pokemon_path(conn, :show, pokemon))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pokemon = Functions.get_pokemon!(id)
    render(conn, "show.html", pokemon: pokemon)
  end

  def edit(conn, %{"id" => id}) do
    pokemon = Functions.get_pokemon!(id)
    changeset = Functions.change_pokemon(pokemon)
    render(conn, "edit.html", pokemon: pokemon, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pokemon" => pokemon_params}) do
    pokemon = Functions.get_pokemon!(id)

    case Functions.update_pokemon(pokemon, pokemon_params) do
      {:ok, pokemon} ->
        conn
        |> put_flash(:info, "Pokemon updated successfully.")
        |> redirect(to: Routes.pokemon_path(conn, :show, pokemon))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pokemon: pokemon, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pokemon = Functions.get_pokemon!(id)
    {:ok, _pokemon} = Functions.delete_pokemon(pokemon)

    conn
    |> put_flash(:info, "Pokemon deleted successfully.")
    |> redirect(to: Routes.pokemon_path(conn, :index))
  end
end
