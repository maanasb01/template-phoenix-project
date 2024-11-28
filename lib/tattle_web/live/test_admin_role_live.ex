defmodule TattleWeb.TestAdminRoleLive do
  use TattleWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Hello Admin!!</h1>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

end