defmodule ChatterWeb.UserController do
  use ChatterWeb, :controller

  alias Chatter.Accounts
  alias Chatter.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Chatter.Accounts.create_user(params) do
      {:ok, %User{} = user} ->
        conn
        |> Doorman.Login.Session.login(user)
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
