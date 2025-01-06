defmodule TattleWeb.Plugs.AuthenticateApi do
  use TattleWeb, :controller

  require Logger
  alias Tattle.Accounts
  alias Tattle.Api.Token

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      try do
        conn |> assign(:current_user, Accounts.get_user!(data.user_id))
      rescue
        _exception -> conn |> put_status(:unauthorized) |> json(%{error: "Access is Unauthorized"})
      end
    else
      _error -> conn |> put_status(:unauthorized) |> json(%{error: "Access is Unauthorized"})
    end
  end

end
