defmodule MyPersonalSpaceWeb.AddLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <p>Hello world!</p>

    <button phx-click="hi">click me!</button>
    """
  end

  def handle_event("hi", params, socket) do
    IO.puts("Handling event")

    {:noreply, socket}
  end
end
