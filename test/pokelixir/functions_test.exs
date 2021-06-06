defmodule Pokelixir.FunctionsTest do
  use Pokelixir.DataCase

  alias Pokelixir.Functions

  describe "pokemons" do
    alias Pokelixir.Functions.Pokemon

    @valid_attrs %{name: "some name", type: "some type"}
    @update_attrs %{name: "some updated name", type: "some updated type"}
    @invalid_attrs %{name: nil, type: nil}

    def pokemon_fixture(attrs \\ %{}) do
      {:ok, pokemon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Functions.create_pokemon()

      pokemon
    end

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Functions.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Functions.get_pokemon!(pokemon.id) == pokemon
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      assert {:ok, %Pokemon{} = pokemon} = Functions.create_pokemon(@valid_attrs)
      assert pokemon.name == "some name"
      assert pokemon.type == "some type"
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Functions.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{} = pokemon} = Functions.update_pokemon(pokemon, @update_attrs)
      assert pokemon.name == "some updated name"
      assert pokemon.type == "some updated type"
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Functions.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Functions.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Functions.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Functions.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Functions.change_pokemon(pokemon)
    end
  end
end
