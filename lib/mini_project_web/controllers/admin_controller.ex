defmodule MiniProjectWeb.AdminController do
  use MiniProjectWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end
end