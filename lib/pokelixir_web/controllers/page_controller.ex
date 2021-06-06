defmodule PokelixirWeb.PageController do
  use PokelixirWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
