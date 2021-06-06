defmodule PokelixirWeb.PokemonControllerTest do
  use PokelixirWeb.ConnCase

  alias Pokelixir.Functions

  @create_attrs %{name: "some name", type: "some type"}
  @update_attrs %{name: "some updated name", type: "some updated type"}
  @invalid_attrs %{name: nil, type: nil}

  def fixture(:pokemon) do
    {:ok, pokemon} = Functions.create_pokemon(@create_attrs)
    pokemon
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pokemons"
    end
  end

  describe "new pokemon" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pokemon"
    end
  end

  describe "create pokemon" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pokemon_path(conn, :show, id)

      conn = get(conn, Routes.pokemon_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pokemon"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pokemon"
    end
  end

  describe "edit pokemon" do
    setup [:create_pokemon]

    test "renders form for editing chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = get(conn, Routes.pokemon_path(conn, :edit, pokemon))
      assert html_response(conn, 200) =~ "Edit Pokemon"
    end
  end

  describe "update pokemon" do
    setup [:create_pokemon]

    test "redirects when data is valid", %{conn: conn, pokemon: pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @update_attrs)
      assert redirected_to(conn) == Routes.pokemon_path(conn, :show, pokemon)

      conn = get(conn, Routes.pokemon_path(conn, :show, pokemon))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pokemon: pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pokemon"
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, Routes.pokemon_path(conn, :delete, pokemon))
      assert redirected_to(conn) == Routes.pokemon_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.pokemon_path(conn, :show, pokemon))
      end
    end
  end

  defp create_pokemon(_) do
    pokemon = fixture(:pokemon)
    {:ok, pokemon: pokemon}
  end
end
