defmodule MyPersonalSpace.Shortener do
  use GenServer

  @chars Enum.concat([?a..?z, ?A..?Z, ?0..?9]) |> to_string() |> String.split("")

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, %{links: %{}}}
  end

  # Public

  def add_link(link) do
    GenServer.call(__MODULE__, {:add_link, link})
  end

  def get_link(slug) do
    GenServer.call(__MODULE__, {:get_link, slug})
  end

  def get_links() do
    GenServer.call(__MODULE__, :get_links)
  end

  # Private

  def handle_call({:add_link, link}, _from, %{links: links}) do
    slug = generate_slug()
    new_links = Map.put(links, slug, link)

    {:reply, slug, %{links: new_links}}
  end

  def handle_call({:get_link, slug}, _from, state = %{links: links}) do
    {:reply, Map.get(links, slug), state}
  end

  def handle_call(:get_links, _from, state = %{links: links}) do
    {:reply, links, state}
  end

  # Other

  defp generate_slug() do
    1..4
    |> Enum.map(fn _ -> Enum.random(@chars) end)
    |> Enum.join()
  end
end
