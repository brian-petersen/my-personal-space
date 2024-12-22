defmodule MyPersonalSpaceWeb.SqlDashboard do
  use Phoenix.LiveDashboard.PageBuilder

  alias Ecto.Adapters.SQL
  alias MyPersonalSpace.Repo

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, error: nil, result: nil, query: "")}
  end

  @impl true
  def menu_link(_session, _capabilities) do
    {:ok, "SQL"}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <form class="mb-3" phx-change="change" phx-submit="submit">
      <div class="input-group">
        <textarea class="form-control" name="query" rows="5"><%= @query %></textarea>
        <button class="btn btn-primary" type="submit">Run</button>
      </div>
    </form>

    <%= if not is_nil(@error) do %>
      <section>
        <p class="mb-1">Error occurred!</p>
        <code style="white-space: pre">{inspect(@error, pretty: true)}</code>
      </section>
    <% end %>

    <%= if not is_nil(@result) and is_list(@result.columns) and is_list(@result.rows) do %>
      <section style="overflow: scroll">
        <table class="table bg-white">
          <thead>
            <tr>
              <%= for column <- @result.columns do %>
                <th scope="col">{column}</th>
              <% end %>
            </tr>
          </thead>
          <tbody>
            <%= for row <- @result.rows do %>
              <tr>
                <%= for item <- row do %>
                  <td>{item}</td>
                <% end %>
              </tr>
            <% end %>
          </tbody>
        </table>
      </section>
    <% end %>

    <%= if not is_nil(@result) and not is_list(@result.columns) do %>
      <section>
        <p class="mb-1">Results</p>
        <code style="white-space: pre">{inspect(@result, pretty: true)}</code>
      </section>
    <% end %>
    """
  end

  @impl true
  def handle_event("change", %{"query" => query}, socket) do
    {:noreply, assign(socket, query: query)}
  end

  def handle_event("submit", %{"query" => query}, socket) do
    Logger.warning("Performing query: #{query}")

    case SQL.query(Repo, query) do
      {:ok, result} -> {:noreply, assign(socket, error: nil, result: result)}
      {:error, error} -> {:noreply, assign(socket, error: error, result: nil)}
    end
  end
end
